Feature: Star System Creation

Scenario: Star System Creation
  When I create a Star System
  Then it should have a technology rating
  And it should have a resources rating
  And it should have a environment rating
  
Scenario: Named Star System Creation
  When I create a Star System with name "Sparta [T1 E-2 R3]"
  Then it should have a technology rating of 1
  And it should have a resources rating of 3
  And it should have a environment rating of -2