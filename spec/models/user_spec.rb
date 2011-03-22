require 'spec_helper'

describe User do
  it "should extract nick from vk data 1" do
    vk_data = {
        "uid"=>"1662467",
        "first_name"=>"Михаил",
        "last_name"=>"Last name",
        "nickname"=>"",
        "sex"=>"2",
        "photo"=>"http://cs9833.vkontakte.ru/u1662467/e_e5d07f24.jpg",
        "authenticity_token"=>"secret="
    }

    user = User.find_or_create_for_vkontakte_oauth vk_data
    user.nick.should eql(vk_data['first_name'])
    user.avatar.should eql(vk_data['photo'])
  end

  it "should extract nick from vk data if nick is busy" do
    vk_data_1 = {
        "uid"=>"125863073",
        "first_name"=>"Андрей",
        "last_name"=>"&#13;",
        "nickname"=>"Nerf",
        "sex"=>"2",
        "photo"=>"http://cs5086.vkontakte.ru/u125863073/e_a6a0d420.jpg",
        "authenticity_token"=>"secret"
    }
    user_1 = User.find_or_create_for_vkontakte_oauth vk_data_1
    user_1.nick.should eql(vk_data_1['nickname'])


    vk_data_2 = vk_data_1.merge 'nickname' => '', 'first_name' => 'Nerf'
    user_2 = User.find_or_create_for_vkontakte_oauth vk_data_2
    user_2.nick.should eql(vk_data_2['first_name'] + '1')

  end
end
