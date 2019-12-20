Feature: Ask a question

  Scenario: Ask Question
    Given I am in a "session"
    When I tap the "add a question" button
    And I input "MyQuestion" in the "Type here" field
    And I tap the "Submit" button
    Then I expect the "question" "MyQuestion" to be displayed