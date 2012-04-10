Feature: Star System Creation

Scenario: Star System Creation
  When I create a Star System
  Then it should have a technology rating
  And it should have a resource rating
  And it should have a environment rating