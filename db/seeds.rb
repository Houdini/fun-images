# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

p "Start generating super admins"
admins = %w(dmitrii.golub@gmail.com palam4ik@gmail.com)
admins.each do |email|
  unless User.find :first, :conditions => {:email => email}
    admin = User.create :email => email, :password => '123456', :password_confirmation => '123456'
    admin.role = 0
    admin.save

    p "S-admin: #{admin.email} generated"
  end
end
