Rails.application.sprites do
  sprite :logos do
    Dir[Rails.root.join('public/images/logo/*.{png}')].each do |path|
      image_path = path[%r{^.*/public/images/(.*)$}, 1]
      klass_name = ".logo.#{File.basename(image_path, File.extname(image_path)).split(' ').join('_')}"
      sp image_path => klass_name
    end
  end
end