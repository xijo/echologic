# Helper module for the static_content of echoLogic.
#
module StaticContentHelper


  # Inserts the breadcrumb for the given main and sub menu point 
  def insert_breadcrumb(main_link, sub_link, sub_menu_title='.title', show_illustration=true)
    controller = request[:controller].split('/')[1]
    action = request[:action]
    title_translation = I18n.t("static.#{controller}.title")
    if main_link != sub_link
      if show_illustration
        pic_resource = "page/illustrations/#{controller}_#{action}_small.png"
        concat image_tag(pic_resource, {:class => 'cornerIllustration'})
      end
      subtitle_translation = I18n.t("static.#{controller}.#{action}" + sub_menu_title)
    else
      subtitle_translation = I18n.t("static.#{controller}.subtitle")
    end

    main_menu = "<h1 class='link'>#{title_translation}</h1>"
    concat link_to(main_menu, url_for(:controller => controller, :action => 'show'))
    concat "<h2>#{subtitle_translation}</h2>"
  end

  # Inserts illustrations as a link for the given array of paths.
  def insert_illustrations(links)
    concat "<div class='illustrationHolder" + (links.size==3 ? " threeItems" : '') + "'>"
    links.each do |link|
      parts = link.split('/')
      item = parts[2,3].join('_')
      pic_resource = 'page/illustrations/' + item + '.png'
      translation = I18n.t("static.#{parts[2,3].join('.')}.title")
      illustration = "<div class='illustration'>"
      illustration +=   image_tag(pic_resource)
      illustration +=   "<h2>#{translation}</h2>"
      illustration += "</div>"
      concat link_to(illustration, {:url => link}, :href => link)
    end
    concat "</div>"
  end

  # Insert back and next buttons according to the given paths.
  # TODO w3c forbids block in anchor!
  def insert_back_next_buttons(prev_link, next_link)
    back_button = "<div id='previousPageButton' class='changePageButton'>#{I18n.t('application.general.back')}</div>"
    next_button = "<div id='nextPageButton' class='changePageButton'>#{I18n.t('application.general.next')}</div>"
    concat "<div class='backNextHolder'>"
    concat link_to(back_button, prev_link, :class => 'prevNextButton')
    concat "<div class='separator'></div>"
    concat link_to(next_button, next_link, :class => 'prevNextButton')
    concat "</div>"
  end

  # Inserts a static menu button with the information
  # provided through the given link.
  # Set ID for a-Tag to the menu name, to store it in the url fragment when
  # using javascript. @see application.js
  def insert_static_menu_button(link)
    item = link.split('/')[2]
    title = "static.#{item}.title"
    subtitle = "static.#{item}.subtitle"
    button = get_static_menu_image(item, link)
    button += "<span class='menuTitle'>#{I18n.t(title)}</span><br/>"
    button += "<span class='menuSubtitle'>#{I18n.t(subtitle)}</span>"
    link_to(button, {:url => link}, :href => link, :class => 'staticMenuButton', :id => item.split('_')[0])
  end

  # Returns the image filename (on of off state) for a specific item.
  # TODO all this splitting is performance critical - find solution! - singleton, class variable?
  def get_static_menu_image(item, link)
    image = /src=\"(.*)\"/.match(image_tag('page/staticMenu/' + item + '.png'))[1]
    active_menu = request.path.split('/')[0..2].join('/').eql?(link) ? 'activeMenu' : ''
    "<div class='menuImage #{active_menu}' style='background: url(#{image})'></div>"
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
    concat("<span class='hideButton' style='display:none;'>#{I18n.t('application.general.hide')}</span>")
    concat("<span class='moreButton'>#{I18n.t('application.general.more')}</span>")
    concat("<div style='display: none;'>")
      concat("#{text}")
    concat("</div>")
  end

end
