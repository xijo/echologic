#
When /^I follow the "([^\"]*)" link within the "([^\"]*)" (.*)$/ do |link, selector, container|
  within "##{selector.downcase.strip.gsub(' ', '_')}_#{container.strip.downcase}" do
    click_link "#{link.downcase.gsub(' ', '_')}_link"
  end
end

When /^I press the "([^\"]*)" button within the "([^\"]*)" (.*)$/ do |button, selector, container|
  button = button.downcase.gsub(" ", "_")
  selector = selector.downcase.gsub(" ", "_")
  within "##{selector}_#{container}" do
    click_button "#{button}_button"
  end
end

When /^I press the "([^\"]*)" button$/ do |button|
  button = button.downcase.gsub(" ", "_")
  click_button "#{button}_button"
end

# Examples:
#   I should not see the admin tab
#   I should see the personal container
#   I should see the edit link
#   I should see the update button
Then /^I should not see the "([^\"]*)" (.*)$/ do |name, component|
  name = name.downcase.gsub(' ', '_')
  component.downcase!
  response.should_not have_selector("##{name}_#{component}")
end

Then /^I should see the "([^\"]*)" (.*)$/ do |name, component|
  response.should have_selector("##{name.downcase.gsub(' ','_')}_#{component.downcase}")
end

Then /^I should see a "([^\"]*)" (.*)$/ do |name, component|
  name = name.downcase.gsub(' ', '_')
  component.downcase!
  response.should have_selector(".#{name.downcase}_#{component}")
end
