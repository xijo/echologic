# Helper module for the static_content of echoLogic.
#
module StaticContentHelper
  
  # Creates a css tab object with a specific name and link.
  # If the relating action was requested, the tab will be
  # displayed highlighted.

  # information needed:
  #  current controller
  #  current action
  #  translation path
  #  tab = active tab?

  # TODO active tab detection in robust way

  def insert_tab(link, ajax=true)
    classname = active_tab?(link)? 'activeTab' : ''
    classname += ' ajax' if ajax
    tab = "<span>#{get_tab_translation(link)}</span>"
    link_to(tab, {:url => link}, :href => link, :class => classname)
  end


  # Returns true if if it is the selected tab. Checks through
  # link and request.
  # TODO detect singular routes like profile - then the anonymous action shouldn't
  # be 'index' but 'show'
  def active_tab?(link)
    link_splitted = link.split('/')
    link_controller = link_splitted[2]
    link_action = link_splitted[3] || 'index'
    request_controller = request[:controller].split('/')[-1]
    request_action = request[:action] || 'index'
    (request_action.eql?(link_action) && request_controller.eql?(link_controller))
  end

  # Returns the db stored translation for a tab with belonging to the given
  # link.
  def get_tab_translation(link)
    tab_name = link.split('/')[-1]
    translation_path = request[:controller].tr('/', '.')
    I18n.t("#{translation_path}.tabs.#{tab_name}")
  end


  # Inserts a disabled tab for not yet implemented functionality. Like a
  # kind of stub
  def insert_tab_stub(name)
    tab = "<span>#{name}</span>"
    link_to(tab, '#')
  end
  
  # Inserts div structure for rounded box
  # Pretty cooler rounded box helper with yield function! Usage makes our
  # views simpler than before and only one method will be needed.
  def insert_rounded_box
    concat "<div class='boxTop'>\n  <div class='boxLeft'></div>"
    concat "  <div class='boxRight'></div>\n</div>"
    concat "<div class='boxMiddle'>\n  <div class='boxMiddleLeft'></div>"
    yield
    concat "</div>\n<div class='boxBottom'>\n  <div class='boxLeft'></div>\n"
    concat "  <div class='boxRight'></div>\n</div>"
  end

  # Inserts the breadcrumb for the given main and sub menu point
  def insert_breadcrumb(main_link, sub_link, sub_menu_title='.title', show_illustration=true)
    controller = request[:controller].split('/')[1]
    action = request[:action]
    if main_link != sub_link
      if show_illustration
        pic_resource = "page/illustrations/#{controller}_#{action}_small.png"
        concat image_tag(pic_resource, {:class => 'cornerIllustration'})
      end
    else
      sub_menu_title = '.subtitle'
    end

    main_menu = "<h1 class='link'>" + I18n.t("static_content.#{controller}.title") + '</h1>'
    concat link_to(main_menu, url_for(:controller => controller))
    # TODO submenutitle remove leading dot
    concat "<h2>#{I18n.t("static_content.#{controller}#{sub_menu_title}")}</h2>"
#
#    main_menu_resource = 'static_content.' + main_link.split('/')[2] + '.title'
#    main_menu = "<h1 class='link'>" + t(main_menu_resource) + '</h1>'
#    concat link_to_remote(main_menu, {:url => main_link}, :href => main_link)
#    concat "<h2>#{t(sub_menu_title)}</h2>"

#    if main_link != sub_link
#      if show_illustration
#        pic_resource = 'page/illustrations/' + sub_link.split('/')[2..3].join('_') + '_small.png'
#        concat image_tag(pic_resource, {:class => 'cornerIllustration'})
#      end
#    else
#      sub_menu_title = '.subtitle'
#    end
#
#    main_menu_resource = 'static_content.' + main_link.split('/')[2] + '.title'
#    main_menu = "<h1 class='link'>" + t(main_menu_resource) + '</h1>'
#    concat link_to_remote(main_menu, {:url => main_link}, :href => main_link)
#    concat "<h2>#{t(sub_menu_title)}</h2>"
  end

  # Inserts illustrations as a link for the given array of paths.
  def insert_illustrations(links)
    concat "<div class='illustrationHolder" + (links.size==3 ? " threeItems" : '') + "'>"
    links.each do |link|
      parts = link.split('/')
      item = parts[2] + '_' + parts[3] 
      pic_resource = 'page/illustrations/' + item + '.png'
      text_resource = 'static_content.' + item + '.title' 
      illustration = "<div class='illustration'>"
      illustration +=   image_tag(pic_resource)
      illustration +=   "<h2>#{t(text_resource)}</h2>"
      illustration += "</div>"
      concat link_to(illustration, {:url => link}, :href => link)
    end
    concat "</div>"
  end
  
  # Insert back and next buttons according to the given paths.
  # TODO w3c forbids block in anthor!
  def insert_back_next_buttons(prev_link, next_link)
    back_button = "<div id='previousPageButton' class='changePageButton'>#{t('general.back')}</div>"
    next_button = "<div id='nextPageButton' class='changePageButton'>#{t('general.next')}</div>"
    concat "<div class='backNextHolder'>"
    concat link_to(back_button, prev_link, :class => 'prevNextButton')
    concat "<div class='separator'></div>"
    concat link_to(next_button, next_link, :class => 'prevNextButton')
    concat "</div>"
  end
  
  # Inserts a static remote menu button with the information
  # provided through the given link.
  # Set ID for a-Tag to the menu name, to store it in the url fragment when
  # using javascript. @see application.js

  # TODO refactor: no longer remote. ajax handled by jquery, @see application.js
  def insert_static_remote_button(link)
    item = link.split('/')[2]
    title = "static_content.#{item}.title"
    subtitle = "static_content.#{item}.subtitle"
    button = get_static_menu_image(item, link)
    button += "<span class='menuTitle'>#{I18n.t(title)}</span><br/>"
    button += "<span class='menuSubtitle'>#{I18n.t(subtitle)}</span>"
    link_to(button, {:url => link}, :href => link, :class => 'staticMenuButton', :id => item.split('_')[0])
  end

  # Returns the image filename (on of off state) for a specific item.
  def get_static_menu_image(item, link)
    image = /src=\"(.*)\"/.match(image_tag('page/staticMenu/' + item + '.png'))[1]
    active_menu = request.path.split('/')[0..2].join('/').eql?(link) ? 'activeMenu' : ''
    "<div class='menuImage #{active_menu}' style='background: url(#{image})'></div>"
  end

  # Inserts a link to a outer menu item. Will be ajaxized through jQuery
  # in application.js. If no special id is set the actual name is used.
  def insert_outer_menu_item(name, link, id=name)
    link_to(t('.'+name), {:url => link}, :href => link, :class => 'outerMenuItem', :id => id)
  end


  
  # Container is only visible in echologic
  def display_echologic_container
    request[:controller].eql?('static/echologic') ? '' : "style='display:none'"
  end
  
  # tabContainer is not visible in echologic
  def display_tab_container
    request[:controller].eql?('static/echologic') ? "style='display:none'" : ''
  end

  # gets the latest twittered content of the specified user account
  # via json.
  # RESCUES: SocketError, Exception
  def get_twitter_content
    begin
      require 'open-uri'
      require 'json'
      buffer = open("http://twitter.com/users/show/echologic.json").read
      result = JSON.parse(buffer)
      html = "<span class='newsDate'>#{l(result['status']['created_at'].to_date, :format => :long)}</span><br/>"
      html += "<span class='newsText'>#{result['status']['text']}</span>"
    rescue SocketError
      'twitter connection failed although all this magic stuff!'
    rescue
      "<span class='newsText'>" + '"Tweet! Tweet! :-)"' + '</span>'
    end
  end
  
  # Inserts text area with the given text and two buttons for opening and
  # closing the area.
  # Click-functions are added via jQuery, take a look at application.js
  def insert_toggle_more(text)
    concat("<span class='hideButton' style='display:none;'>#{t('general.hide')}</span>")
    concat("<span class='moreButton'>#{t('general.more')}</span>")
    concat("<div style='display: none;'>")
      concat("#{text}")
    concat("</div>")
  end

end
