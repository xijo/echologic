# Helper module for the static_content of echoLogic.
#
module StaticContentHelper
  
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
  
  # Insert the top elements of a rounded box
  def insert_rounded_box_top
    <<-TOP
<div class="boxTop">
    <div class="boxLeft"></div>
    <div class="boxRight"></div>
  </div>
  <div class="boxMiddle">
    <div class="boxMiddleLeft"></div>
    TOP
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
  
  # Inserts a static menu button with the information
  # provided through the given link.
  def insert_static_menu_button(link)
    item = link.split('/')[1]
    title = 'static_content.'+item+'.title'
    subtitle = 'static_content.'+item+'.subtitle'
    <<-BUTTON
  <a class='staticMenuButton' href='#{link}'>
    #{image_tag insert_static_menu_image(item)}
    <span class='staticMenuButtonTitle'>#{t(title)}</span><br/>
    <span class='staticMenuButtonSubtitle'>#{t(subtitle)}</span>
  </a>
    BUTTON
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
  
end
