Feature: Cluster creation

Scenario: Cluster creation
  When I request a new cluster with 5 star systems
  Then the output should have 5 nodes
  And the output should have at least 4 edges
  
Scenario: Named systems
  When I create a new cluster with systems "Foo", "Bar", "Baz"
  Then the graph should have nodes "Foo", "Bar", "Baz"
  And the graph should have edges between "Foo", "Bar", "Baz"