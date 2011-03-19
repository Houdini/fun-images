Before('@omni') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
              "provider"=>"facebook",
              "uid"=>"1072811530",
              "credentials"=>{
                  "token"=>"1854629531|2.__5gmRHgYgP530|xQnU3w"
              },
              "user_info"=>{
                  "nickname"=>"codeforlife",
                  "first_name"=>"Dima",
                  "last_name"=>"Golub",
                  "name"=>"Dima Golub",
                  "urls"=>{"Facebook"=>"http://www.facebook.com/codeforlife", "Website"=>nil}
              },
              "extra"=>{
                  "user_hash"=>{
                      "id"=>"1072811530",
                      "name"=>"Dima Golub",
                      "first_name"=>"Dima",
                      "last_name"=>"Golub",
                      "link"=>"http://www.facebook.com/codeforlife",
                      "location"=>{
                          "id"=>"115085015172389",
                          "name"=>"Moscow, Russia"
                      },
                      "education"=>
                          [
                              {"school"=>{"id"=>"108203152547905", "name"=>"BMSTU"},
                               "year"=>{"id"=>"142963519060927", "name"=>"2010"},
                               "type"=>"College"}
                          ],
                      "timezone"=>2,
                      "locale"=>"en_GB",
                      "verified"=>true,
                      "updated_time"=>"2011-01-31T21:42:27+0000"
                  }
              }
          }

  OmniAuth.config.mock_auth[:vkontakte] = {
            "provider" => "vkontakte",
            "uid"=>"3660651",
            "user_info" => {
                "nickname"=>"Houdini",
                "name"=>"\xD0\x94\xD0\xB8\xD0\xBC\xD0\xB0 \xD0\x93\xD0\xBE\xD0\xBB\xD1\x83\xD0\xB1\xD1\x8C",
                "first_name"=>"Ð”Ð¸Ð¼Ð°",
                "last_name"=>"Ð“Ð¾Ð»ÑƒÐ±ÑŒ",
                "image"=>"http://cs10745.vkontakte.ru/u3660651/e_fd714fb5.jpg",
                "urls"=>{
                    "Page"=>"http://vkontakte.ru/id3660651"
                }
            }
        }
end