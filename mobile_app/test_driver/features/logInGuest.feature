Feature: Log In as Guest

  Scenario: Log In when LogIn button pressed
    Given I am in the "Log in" screen
    When I tap the "log in as guest" button
    Then I expect to be logged in as "user" "Anonymous"