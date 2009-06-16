# Helper module for the static_content of echoLogic.
#
module StaticContentHelper
  
  # Creates a css tab object with a specific name and link.
  # If the relating action was requested, the tab will be
  # displayed highlighted.
  # ATTENTION: not optimal yet.
  def insert_tab(name, link)
    tab = "<a href='#{link}' class='"
    case request[:action]
      when "echocracy_citizens"
        tab << "activeTab" if name.eql?(:Citizens)
      when "echocracy_experts"
        tab << "activeTab" if name.eql?(:Experts)
      when "echocracy_orgas"
        tab << "activeTab" if name.eql?(:Organisations)
    end
    tab << "'><div><br/>#{name}</div></a>"
  end
  
  # Inserts partials that belongs to the action.
  def insert_content
    case request[:action]
      when "echocracy_citizens"
        render :partial => "citizens"
      when "echocracy_experts"
        render :partial => "experts"
      when "echocracy_orgas"
        render :partial => "orgas"
      when "echocracy"
        render :partial => "echocracy"
    end
  end
  
end
