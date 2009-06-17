# Helper module for the static_content of echoLogic.
#
module StaticContentHelper
  
  # Creates a css tab object with a specific name and link.
  # If the relating action was requested, the tab will be
  # displayed highlighted.
  # ATTENTION: not optimal yet.
  # ATT2: small workaround.
  def insert_tab(name, link)
    tab = "<a href='#{link}'"
    if request[:action] == name
      tab << " class='activeTab'"
    end
    tab << "><div><br/>#{t('static_content.' + name + '.title')}</div></a>"
  end
  
  # Insert the top elements of a rounded box
  def insert_rounded_box_top
    top = <<-TOP
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
    bottom = <<-BOTTOM   
  </div>
  <div class="boxBottom">
    <div class="boxLeft"></div>
    <div class="boxRight"></div>
  </div>
    BOTTOM
  end
  
  # Inserts a static menu button.
  def insert_static_menu_button
    button = <<-BUTTON
  <a class="staticMenuButton" href="<%= echologic_path %>">
      #{image_tag "page/staticMenu/sidemenuicon_mission_off.png"}
      <span class="staticMenuButtonTitle">echologic</span><br/>
      <span class="staticMenuButtonSubtitle">The Mission</span>
    </a>
    BUTTON
  end
  
end
