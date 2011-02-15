namespace :image do
  desc "choose new image and disable last one"
  task :choose => :environment do
    image_to_disable = Image.find :first, :conditions => {:is_shown => true}
    if image_to_disable
      image_to_disable.is_shown = false
      image_to_disable.was_shown = true
      image_to_disable.save
    end
  end
end