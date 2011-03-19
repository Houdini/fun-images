class Admin::WelcomeController < ::AdminController
  def index
    @images = Image.find :all, :conditions => {:shown_date.lt => Date.today + 1.day}, :limit => 10
  end

end
