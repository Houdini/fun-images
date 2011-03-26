Feature: Manage comments

  Scenario: User should see his comment on main page, users comments page and like page if this comment was liked
    Given I am logged in
    Given an image
    And go to the home page
    When I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    And go to the home page
    Then I should see "Comment body"
    And I go to my comments
    Then I should see "Comment body"
    And I go to the home page
    And I follow i18n "log_out"

    And I am logged in "user2"
    And I follow i18n "i_like"
    And I go to the comments I like
    Then I should see "Comment body"

  Scenario: User should like and dislike comment
    Given I am logged in
    Given an image

    And go to the home page
    And I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    And go to the home page
    And I follow i18n "log_out"

    And I am logged in "user2"
    And I follow i18n "i_like"
    And I go to the home page
    And I follow i18n "dont_like"
    And I go to the comments I like
    Then I should not see "Comment body"

  Scenario: Admin should delete comment
    Given I am logged in
    Given an image
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    And I go to my comments
    And I go to the home page
    And I follow i18n "log_out"
    And I am logged in "user2"
    And I follow i18n "i_like"
    And I go to the comments I like
    And I follow i18n "log_out"
    Given I am logged in as admin
    And I go to admin last image
    And I follow i18n "destroy_comment"
    And I go to the home page
    # TODO: make this work with javascript
    # Then I should not see "Comment body"

  Scenario: Prevent save empty new comment
    Given I am logged in
    Given an image
    Then go to the home page
    And I press "comment_submit"
    Then I should see i18n "mongoid.errors.models.comment.attributes.body.too_short"
  
  Scenario: Prevent double vote
    Given I am logged in
    Given an image
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    And go to the home page
    And I follow i18n "log_out"
    And go to the home page
    And I am logged in "user2"
    And I follow i18n "i_like"
    Then I should see i18n "notice.thanks_for_comment" "nick user2"
    And I follow i18n "i_like"
    Then I should see i18n "you_have_already_voted"

  Scenario: Prevent same comment twice
    Given I am logged in
    Given an image
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    Then I should see i18n "mongoid.errors.messages.taken"

  Scenario: Not more then three comments per image
    Given I am logged in
    Given an image
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body2 |
    And I press "comment_submit"
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body3 |  
    And I press "comment_submit"
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body4 |  
    And I press "comment_submit"
    Then I should see i18n "too_much_comments"

  Scenario: User cannot vote for his comment
    Given I am logged in
    Given an image
    And go to the home page
    And I fill in the following:
      | comment_body | Comment body4 |
    And I press "comment_submit"
    And I go to the home page
    And I follow i18n "i_like"
    And I go to the home page
    Then I should not see i18n "notice.thanks_for_comment" "nick user"

# TODO: Webrat error, posted on webrat google group
#  Scenario: User can delete his comment and another user can not
#    Given I am logged in
#    Given an image
#
#    And go to the home page
#    And I fill in the following:
#      | comment_body | Comment body4 |
#    And I press "comment_submit"
#    And go to the home page
#    And I follow i18n "log_out"
#
#    And I am logged in "user2"
#    Then what
#    And I follow i18n "destroy_comment"
#    Then what
#    Then I should see i18n "alert.you_are_not_author"
