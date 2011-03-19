Feature: Manage empty pages

  Scenario: Empty welcome page should be rendered ok
    Given I am logged in
    Given I go to comments I like
    Then page should be ok
    Then I should see "user"

  @omni
  Scenario: See correct pages when logged in via facebook
    Given go to the sign up page
    And I follow "Facebook"
    And I go to facebook callback
    And I go to the main page
    Then page should be ok
    Then I should see "codeforlife"


  @omni
  Scenario: See correct pages when logged in via vkontakte
    Given go to the sign up page
    And I go to vkontakte callback
    And I go to the main page
    Then page should be ok
    Then I should see "Houdini"
