Feature: Manage registrations via different services

  Scenario: Enter bad email
    Given I go to the sign up page
    And I fill in the following:
      | user_email | bla |
      | user_password | 123456 |
      | user_password_confirmation | 123456 |
    And I press "user_submit"
    Then I should not see i18n "devise.registrations.signed_up"

  Scenario: Incorrect password confirmation
    Given I go to the sign up page
    And I fill in the following:
      | user_email | user@gmail.com |
      | user_password | 123456 |
      | user_password_confirmation | abcdefg |
    And I press "user_submit"
    Then I should not see i18n "devise.registrations.signed_up"

    Scenario: Valid data
      Given I go to the sign up page
      And I fill in the following:
        | user_email | user@gmail.com |
        | user_password | 123456 |
        | user_password_confirmation | 123456 |
      And I press "user_submit"
      Then I should see i18n "devise.registrations.signed_up"