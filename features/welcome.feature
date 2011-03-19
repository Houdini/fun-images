Feature: Manage welcome page

  Scenario: Empty welcome page should be rendered ok
    Given I go to the home page
    Then page should be ok

  Scenario: Welcome page with an image should be rendered ok
    Given an image
    Given I go to the home page
    Then page should be ok
    And I should see "Image title"
