Feature: Enter a Session

  Scenario: Enter a Session when a session code is introduced
    Given I enter the "session" screen
    When I input the "session code" "404"
    And I tap the "Go" button
    Then I expect to go to the "session" 404