Feature: Fudge dice

Scenario: Rolling multiple dice
  When I roll 4dF
  Then the result is between -4 and 4