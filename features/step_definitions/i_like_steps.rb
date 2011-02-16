Given /^the following i_likes:$/ do |i_likes|
  ILike.create!(i_likes.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) i_like$/ do |pos|
  visit i_likes_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following i_likes:$/ do |expected_i_likes_table|
  expected_i_likes_table.diff!(tableish('table tr', 'td,th'))
end
