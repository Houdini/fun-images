namespace :migrate do
  desc "migrate shown date type Date to shown date type INTEGER. 23 apr 2011"
  task shown_date_date_to_integer: :environment do
    Image.all.each do |image|
      next if image.shown_date.class == Integer
      p "start convert for #{image.shown_date}"
      image.shown_date = image.shown_date.to_date.to_i
      image.save
    end

    Image.all.each do |image|
      p image.shown_date
    end
  end

  desc "recreate organize_commented_images. 25 apr 2011"
  task organize_commented_images: :environment do
    User.all.each do |user|
      p "user: #{user.nick} - #{user.id}"
      user.commented_images ||= []
      user.comments.each do |comment|
        user.commented_images << comment.image.shown_date
      end
      user.save
    end
  end

  desc "ensure nick if email is present and nick is null. 26 apr 2011"
  task ensure_nick: :environment do
    User.all.each do |user|
      unless user.nick
        if user.email
          user.update_attribute :nick, email.split('@').first
        end
      end
    end
  end
end