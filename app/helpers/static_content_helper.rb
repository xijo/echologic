# Helper module for the static_content of echoLogic.
#
module StaticContentHelper
  
  # DEPRICATED
  # Creates a css tab object with a specific name and link.
  # If the relating action was requested, the tab will be
  # displayed highlighted.
  # ATTENTION: not optimal yet.
  # ATT2: small workaround.
  def insert_tab(link)
    name = link.tr('/', '_')[1..-1]
    tab = "<a href='#{link}'"
    if request[:action].eql?(name)
      tab << " class='activeTab'"
    end
    tab << "><div><br/>#{t('static_content.' + name + '.title')}</div></a>"
  end
  
  # Inserts a tab with a remote link.
  # If the relating action was requested, the tab will be
  # displayed highlighted.  
  def insert_remote_tab(link)
    name = link.tr('/', '_')[4..-1]
    tab = "<div>#{t('static_content.' + name + '.title')}</div>"
    classname = request[:action].eql?(name) ? 'activeTab' : ''
    link_to_remote(tab, {:url => link}, :href => link, :class => classname)
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
  
  # Insert the top elements of a rounded box
  def insert_rounded_box_top
    top =  "<div class='boxTop'>"
    top += "  <div class='boxLeft'></div>"
    top += "  <div class='boxRight'></div>"
    top += "</div>"
    top += "<div class='boxMiddle'>"
    top += "  <div class='boxMiddleLeft'></div>"
  end
  
  # Insert the bottom elements of a rounded box
  def insert_rounded_box_bottom
    <<-BOTTOM   
  </div>
  <div class="boxBottom">
    <div class="boxLeft"></div>
    <div class="boxRight"></div>
  </div>
    BOTTOM
  end

  # Inserts the breadcrumb for the given main and sub menu point
  def insert_breadcrumb(main_link, sub_link, sub_menu_title='.title', show_illustration=true)
    if main_link != sub_link
      if show_illustration 
        pic_resource = 'page/illustrations/' + sub_link.split('/')[2..3].join('_') + '.png'
        concat image_tag(pic_resource, {:class => 'currentIllustration'})
      end
    else
      sub_menu_title = '.subtitle'
    end
    
    main_menu_resource = 'static_content.' + main_link.split('/')[2] + '.title'
    main_menu = "<h1 class='link'>" + t(main_menu_resource) + '</h1>'
    concat link_to_remote(main_menu, {:url => main_link}, :href => main_link)
    concat "<h4>#{t(sub_menu_title)}</h4>"
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
      concat link_to_remote(illustration, {:url => link}, :href => link)
    end
    concat "</div>"
  end
  
  # Insert back and next buttons according to the given paths.
  def insert_back_next_buttons(prev_link, next_link)
    back_button = "<div class='back'>#{t('general.back')}</div>"
    next_button = "<div class='next'>#{t('general.next')}</div>"
    concat "<div class='backNextHolder'>"
    concat link_to_remote(back_button, {:url => prev_link}, :href => prev_link)
    concat "<div class='separator'></div>"
    concat link_to_remote(next_button, {:url => next_link}, :href => next_link)
    concat "</div>"
  end
  
  # Inserts a static remote menu button with the information
  # provided through the given link.  
  def insert_static_remote_button(link)
    item = link.split('/')[2]
    title = 'static_content.'+item+'.title'
    subtitle = 'static_content.'+item+'.subtitle'
    button =  image_tag insert_static_menu_image(item)
    button += "<span class='h1'>#{t(title)}</span><br/>"
    button += "<span class='h2'>#{t(subtitle)}</span>"
    link_to_remote(button, {:url => link}, :href => link, :class => 'staticMenuButton')
  end
  
  # Returns the image filename (on of off state) for a specific item.
  def insert_static_menu_image(item)
    action = request[:action].split('_')[0]
    if (action.eql?(item))
      'page/staticMenu/' + item + '_on.png'
    else
      'page/staticMenu/' + item + '_off.png'
    end
  end
  
  # Container is only visible in echologic
  def display_echologic_container
    request[:action].eql?('echologic') ? '' : "style='display:none'"
  end
  
  # tabContainer is not visible in echlogic
  def display_tab_container
    request[:action].eql?('echologic') ? "style='display:none'" : ''
  end
  
  # display_content
#  def display_content(content)
#    content.each do |key, value|
#      case key.to_s
#        when /\Atext/
#          display_text(value)
#        when /\Apart/
#          concat("part ")
#      end
#    end
#  end
#  
#  # display text
#  def display_text(value)
#    concat("<p>")
#    if value.is_a? String
#      concat("value")
#    elsif value.is_a? Array
#      concat(value.inspect)
#      value.each do |key, part|
#        case key.to_s
#          when /\Apart/
#            concat(part)
#          when /\Alink/
#            concat("<a>#{part[:title]}</a>")
#        end
#      end
#    else
#      concat(value.inspect)
#      display_content(value)
#    end
#    concat("</p>")
#  end

  # gets the latest twittered content of the specified user account
  # via json.
  # WARNING: raises nil error if there haven't been a tweet.
  # rescued: SocketError, NilError
  def get_twitter_content
    begin
      require 'open-uri'
      require 'json'
      buffer = open("http://twitter.com/users/show/echologic.json").read
      result = JSON.parse(buffer)
      html = "<span class='newsDate'>#{result['status']['created_at']}</span><br/>"
      html += "<span class='newsText'>#{result['status']['text']}</span>"
    rescue SocketError
      'twitter connection failed'
    rescue
      '"Tweet! Tweet! :-)"'
    end
  end
  
  # more/hide helper
  def insert_toggle_more(text)
    insert_more_hide_buttons()
    concat("<div style='display: none;'>")
      concat("#{text}")
    concat("</div>")
  end
  
  def insert_more_hide_buttons()
    # hide button
    concat("<span class='moreButton' style='display:none;' onclick=\"")
      concat("$(this).hide();")
      concat("Effect.Appear($(this).next(0), {duration:0.3});")
      concat("Effect.Fade($(this).next(1), {duration:0.4});")
      concat("Effect.BlindUp($(this).next(1), {duration:0.3});")
    concat("\">#{t('general.hide')}</span>")
    # more button
    concat("<span class='moreButton' onclick=\"")
      concat("$(this).hide();")
      concat("Effect.Appear($(this).previous(0), {duration:0.3});")      
      concat("Effect.Appear($(this).next(0), {duration:0.4});")
      concat("Effect.BlindDown($(this).next(0), {duration:0.3});")
    concat("\">#{t('general.more')}</span>")

  end
  
  # more/hide helper
  def insert_more(text)
    concat("<span class='moreButton' onclick=\"")
      concat("Effect.Fade($(this), {duration:0.3});")
      concat("Effect.Appear($(this).next(0), {duration:0.4});")
      concat("Effect.BlindDown($(this).next(0), {duration:0.3});")
      concat("\">#{t('general.more')}</span>")
    concat("<div style='display: none;'>")
      concat("#{text}")
    concat("</div>")
  end
  
end
