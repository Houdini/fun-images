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
end