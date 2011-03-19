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
    when /the main page/
      '/'

    when /the new i_like page/
      new_i_like_path

    when /comments I like/
      comments_i_like_path

    when /my comments/
      my_comments_path

    when /admin last image/
      image = Image.last
      admin_image_path image

    when /the sign up page/
      new_user_registration_path

    when /facebook callback/
      '/users/auth/facebook/callback'

    when /vkontakte callback/
      '/users/auth/vkontakte/callback'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)