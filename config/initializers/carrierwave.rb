#CarrierWave.configure do |config|
#  config.grid_fs_database = Mongoid.database.name
#  config.storage = :grid_fs
#  config.grid_fs_host = Mongoid.database.connection.primary_pool.host
#  config.grid_fs_access_url = "/i"
#end

#CarrierWave.configure do |config|
#  config.permissions = 0777
#  config.storage = :file
#end