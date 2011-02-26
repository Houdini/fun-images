Feature: Manage comments
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: User create new comment, and he can not vote or spam it
    Given I am logged in
    Given an image
    Then go to the home page
    When I fill in the following:
      | comment_body | Comment body |
    And I press "comment_submit"
    Then go to the home page
    Then I should see "Comment body"

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
    Then I should see i18n "thanks_for_comment" "nick user2"
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
    And I go to the home page
    Then what
    Then I should see i18n "same_comment_again"
  





#    Given I am on the new i_like page
#    And I press "Create"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
#  Scenario: Delete i_like
#    Given the following i_likes:
#      ||
#      ||
#      ||
#      ||
#      ||
#    When I delete the 3rd i_like
#    Then I should see the following i_likes:
#      ||
#      ||
#      ||
#      ||
