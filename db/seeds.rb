# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

p "Start generating super admins"
unless User.find :first, :conditions => {:email => 'dmitrii.golub@gmail.com'}
  admin = User.create :email => 'dmitrii.golub@gmail.com', :password => '123456', :password_confirmation => '123456'
  admin.role = 0
  admin.save

  p "S-admin: #{admin.email} generated"
end