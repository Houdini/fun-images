module AdminHelper
  def oauth_links oauth_array
    res = ''
    oauth_array.each do |oauth|
      provider, id = oauth.split
      if provider == 'vk'
        res << "<a href='http://vkontakte.ru/id#{id}'><div class='logo #{provider}'></div></a>"
      elsif provider == 'facebook'
        res << "<a href='http://facebook.com/profile.php?id=#{id}'><div class='logo #{provider}'></div></a>"
      end
    end
    res.html_safe
  end
end