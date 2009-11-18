module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
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
      '/connect/profiles'
    when /^create a question$/
      new_question_path
    when /^the question$/
      question_path(@question)
    when /^the first question$/
      question_path(Question.first)
      
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        paths = page_name.split(' ') - ['the', 'page'] + ['path']
        send(paths.join('_'))
      rescue
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
