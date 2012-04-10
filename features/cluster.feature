Feature: Cluster creation

Scenario: Cluster creation
  When I request a new cluster with 5 star systems
  Then the output should have 5 nodes
  And the output should have at least 4 edges