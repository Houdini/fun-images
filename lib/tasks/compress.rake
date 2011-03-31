namespace :compress do
  desc "compress javascripts"
  task :js => :environment do
    files = %w(mustache jquery rails jquery.cookie gritter/jquery.gritter.min jquery.tipsy application)
    `rm -f #{Rails.root.to_s}/public/javascripts/temp.js`
    files.each do |file|
      `cat #{Rails.root.to_s}/public/javascripts/#{file}.js >> #{Rails.root.to_s}/public/javascripts/temp.js`
    end
    `java -jar /media/data/opt/yuicompressor*/build/yuicompressor-2.4.2.jar #{Rails.root.to_s}/public/javascripts/temp.js -o #{Rails.root.to_s}/public/javascripts/application.min.js`
    `rm -f #{Rails.root.to_s}/public/javascripts/temp.js`
  end
end