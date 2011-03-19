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

Given /^I am logged in as admin$/ do
  admin_name = 'admin'
  visit new_user_registration_path
  fill_in 'user_email', :with => "#{admin_name}@gmail.com"
  fill_in 'user_password', :with => '123456'
  fill_in 'user_password_confirmation', :with => '123456'
  click_button 'user_submit'
  user = User.find :first, :conditions => {:email => "#{admin_name}@gmail.com"}
  user.role = 0
  user.save
end


Given /^an image$/ do
  image = Image.new :title => 'Image title', :image => File.open("#{Rails.root.to_s}/public/images/logo.png"), :shown_date => Date.today
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

Then /^(?:|I )should not see i18n "([^"]*)"$/ do |text|
  if response.respond_to? :should_not
    response.should_not contain(I18n.t text)
  else
    assert_not_contain(I18n.t text)
  end
end

Then /^(?:|I )should see i18n "([^"]*)" "([^"]*)"$/ do |text, interpolation|
  res = {}
  interpolation_res = interpolation.split.each_pair do |key, value|
    res[key.to_sym] = value
  end
  if response.respond_to? :should
    response.should contain(I18n.t text, res)
  else
    assert_contain (I18n.t text, res)
  end
end


Then /^Facebook returns (.*)$/ do |returns|
  Devise::OmniAuth.short_circuit_authorizers!

  Devise::OmniAuth.stub!(:facebook) do |b|
    access_token = {
      :access_token => "plataformatec"
    }

    b.post('/oauth/access_token') { [200, {}, access_token.to_json] }

    facebook = {
      :id => '12345',
      :link => 'http://facebook.com/user_example',
      :email => 'user@example.com',
      :first_name => 'User',
      :last_name => 'Example',
      :website => 'http://blog.plataformatec.com.br'
    }

    b.get('https://graph.facebook.com/oauth/authorize?client_id=121291144597463&redirect_uri=http%3A%2F%2Fwww.example.com%2Fusers%2Fauth%2Ffacebook%2Fcallback&scope=email%2Coffline_access&type=web_server') { [200, {}, facebook.to_json] }
  end

  visit '/users/auth/facebook'

  # hash = {}
  # returns.split(/,\s+/).each do |part|
  #   if part =~ /([a-z_]+):"([a-zA-Z0-9 \@\.]+)"/
  #     hash[$1.to_sym] = $2
  #   else
  #     raise "Could not match Facebook #{part}"
  #   end
  # end
  # hash

  #Devise::OmniAuth.unshort_circuit_authorizers!

  #Devise::OmniAuth.reset_stubs!
end

Given /^I have valid facebook credentials$/ do
  module OmniAuth
    module Strategies
      class OAuth2
        def request_phase
          redirect callback_url
        end
        def callback_phase
          @env['rack.auth'] = {
              "provider"=>"facebook",
              "uid"=>"1072811530",
              "credentials"=>{
                  "token"=>"1854629531|2.__5gmRHgYgP530|xQnU3w"
              },
              "user_info"=>{
                  "nickname"=>"codeforlife",
                  "first_name"=>"Dima",
                  "last_name"=>"Golub",
                  "name"=>"Dima Golub",
                  "urls"=>{"Facebook"=>"http://www.facebook.com/codeforlife", "Website"=>nil}
              },
              "extra"=>{
                  "user_hash"=>{
                      "id"=>"1072811530",
                      "name"=>"Dima Golub",
                      "first_name"=>"Dima",
                      "last_name"=>"Golub",
                      "link"=>"http://www.facebook.com/codeforlife",
                      "location"=>{
                          "id"=>"115085015172389",
                          "name"=>"Moscow, Russia"
                      },
                      "education"=>
                          [
                              {"school"=>{"id"=>"108203152547905", "name"=>"BMSTU"},
                               "year"=>{"id"=>"142963519060927", "name"=>"2010"},
                               "type"=>"College"}
                          ],
                      "timezone"=>2,
                      "locale"=>"en_GB",
                      "verified"=>true,
                      "updated_time"=>"2011-01-31T21:42:27+0000"
                  }
              }
          }
          call_app!
        end
      end
    end
  end
end