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
  
  # Inserts a static remote menu button with the information
  # provided through the given link.  
  def insert_static_remote_button(link)
    item = link.split('/')[2]
    title = 'static_content.'+item+'.title'
    subtitle = 'static_content.'+item+'.subtitle'
    button =  image_tag insert_static_menu_image(item)
    button += "<span class='staticMenuButtonTitle'>#{t(title)}</span><br/>"
    button += "<span class='staticMenuButtonSubtitle'>#{t(subtitle)}</span>"
    link_to_remote(button, {:url => link}, :href => link, :class => 'staticMenuButton')
  end
  
  # Returns the image filename (on of off state) for a specific item.
  # Workaround for name convention echo <-> echo_on_waves
  def insert_static_menu_image(item)
    action_parts = request[:action].split('_')
    action_parts[1].eql?('on') ? action = 'echo_on_waves' : action = action_parts[0]
    if (action.eql?(item))
      'page/staticMenu/' + item + '_on2.png'
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
  def display_content(content)
    content.each do |key, value|
      case key.to_s
        when /\Atext/
          display_text(value)
        when /\Apart/
          concat("part ")
      end
    end
  end
  
  # display text
  def display_text(value)
    concat("<p>")
    if value.is_a? String
      concat("value")
    elsif value.is_a? Array
      concat(value.inspect)
      value.each do |key, part|
        case key.to_s
          when /\Apart/
            concat(part)
          when /\Alink/
            concat("<a>#{part[:title]}</a>")
        end
      end
    else
      concat(value.inspect)
      display_content(value)
    end
    concat("</p>")
  end
  
  #
  def insert_list(array, options={})
    list_type = options[:ordered] ? ["<ol>", "</ol>"] : ["<ul>", "</ul>"]
    concat(list_type.first)
    array.each do |li|
      if li.is_a?(String)
        concat("<li>#{li}</li>")
      elsif li.is_a?(Hash)
        concat(list_type.first)
        li.each_value do |lii|
          concat("<li>#{lii}</li>")
        end
        concat(list_type.last)
      elsif li.is_a?(Array)
        concat(list_type.first)
        li.each do |lii|
          concat("<li>#{lii}</li>")
        end
        concat(list_type.last)
      end
    end
    concat(list_type.last)
  end
  
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
      result['status']['text']
    rescue SocketError
      'twitter connection failed'
    rescue
      'unknown error'
    end
  end
  
  # more/hide helper
  def insert_toggle_more(text)
    concat("<span class='moreButton' onclick=\"")
      concat("Effect.Fade($(this), {duration:0.3});")
      concat("Effect.Appear($(this).next(0), {duration:0.4});")
      concat("Effect.BlindDown($(this).next(0), {duration:0.3});")
      concat("\">#{t('general.more')}</span>")
    concat("<div style='display: none;'>")
      concat("#{text}")
#      concat("<span class='hideButton' onclick=\"")
#       concat("Effect.BlindUp($(this).up(0), {duration:0.3});")
#       concat("Effect.Fade($(this).up(0), {duration:0.4});")
#       concat("Effect.Appear($(this).up().previous(), {duration:0.3});")
#      concat("\">#{t('general.hide')}</span>")
    concat("</div>")
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
