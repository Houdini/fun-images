namespace :regular do
  desc "recalculating users rating"
  task recalculate_user_rating: :environment do
    User.recalculate_rating_place
  end
end