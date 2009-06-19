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
    name = link.tr('/', '_')[1..-1]
    tab = "<div><br/>#{t('static_content.' + name + '.title')}</div>"
    request[:action].eql?(name) ? classname = 'activeTab' : classname = ''
    link_to_remote (tab, {:url => link}, :href => link, :class => classname)
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
  
  # DEPRICATED
  # Inserts a static menu button with the information
  # provided through the given link.
  def insert_static_menu_button(link)
    item = link.split('/')[1]
    title = 'static_content.'+item+'.title'
    subtitle = 'static_content.'+item+'.subtitle'
    button = <<-BUTTON
  <a class='staticMenuButton' href='#{link}'>
    #{image_tag insert_static_menu_image(item)}
    <span class='staticMenuButtonTitle'>#{t(title)}</span><br/>
    <span class='staticMenuButtonSubtitle'>#{t(subtitle)}</span>
  </a>
    BUTTON
  end

  # Inserts a static remote menu button with the information
  # provided through the given link.  
  def insert_static_remote_button(link)
    item = link.split('/')[1]
    title = 'static_content.'+item+'.title'
    subtitle = 'static_content.'+item+'.subtitle'
    button =  image_tag insert_static_menu_image(item)
    button += "<span class='staticMenuButtonTitle'>#{t(title)}</span><br/>"
    button += "<span class='staticMenuButtonSubtitle'>#{t(subtitle)}</span>"
    link_to_remote (button, {:url => link}, :href => link, :class => 'staticMenuButton')
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
  
  # promoContainer is only visible in echlogic
  def display_echologic_promo_container
    request[:action].eql?('echologic') ? '' : "style='display:none'"
  end
  
  # tabContainer is not visible in echlogic
  def display_tab_container
    request[:action].eql?('echologic') ? "style='display:none'" : ''
  end  
  
end
