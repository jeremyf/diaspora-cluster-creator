Feature: Node Creation

Scenario: Node Creation
  When I create a Node
  Then it should have a technology rating
  And it should have a resources rating
  And it should have a environment rating
  
Scenario: Named Node Creation
  When I create a Node with name "Sparta [T1 E-2 R3]"
  Then it should have a technology rating of 1
  And it should have a resources rating of 3
  And it should have a environment rating of -2