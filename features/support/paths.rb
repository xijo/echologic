module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /the profile/
      my_profile_path
    when /the start page/
      root_path
    when /the connect page/
      connect_path
    when /the welcome page/
      welcome_path
    when /the reports page/
      reports_path
    when /^create a question$/
      new_question_path(:category => 'echonomyJAM')
    when /^the question$/
      question_path(@question)
    when /^the proposal$/
      question_proposal_path(@proposal.parent,@proposal)
    when /^the first question$/
      question_path(Question.first)
    when /^the questions first proposal/
      question_proposal_path(@question, @proposal)
    when /discuss index/i
      questions_url
    when /the proposal/
      raise [@proposal.inspect,@proposal.parent.inspect].join('\n')
      question_proposal_path(@proposal.parent, @proposal)
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
