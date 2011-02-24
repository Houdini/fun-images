Then /^what$/ do
  save_and_open_page
end

Then /^page should be ok$/ do
  assert 200 == response.status, "Expected status to be 200, got #{response.status}"
end

Given /^I am logged in$/ do
  visit new_user_registration_path
  fill_in 'user_email', :with => 'user@gmail.com'
  fill_in 'user_password', :with => '123456'
  fill_in 'user_password_confirmation', :with => '123456'
  click_button 'user_submit'
end

Given /^I am logged in "([^"]*)"$/ do |user_name|
  visit new_user_registration_path
  fill_in 'user_email', :with => "#{user_name}@gmail.com"
  fill_in 'user_password', :with => '123456'
  fill_in 'user_password_confirmation', :with => '123456'
  click_button 'user_submit'
end

Given /^an image$/ do
  image = Image.new :title => 'Image title', :image => File.open("#{Rails.root.to_s}/public/images/rails.png"), :shown_date => Date.today
  image.save
end

When /^(?:|I )press i18n "([^"]*)"$/ do |button|
  click_button(I18n.t button)
end


When /^(?:|I )follow i18n "([^"]*)"$/ do |link|
  click_link(I18n.t link)
end


Then /^(?:|I )should see i18n "([^"]*)"$/ do |text|
  if response.respond_to? :should
    response.should contain(I18n.t text)
  else
    assert_contain (I18n.t text)
  end
end
