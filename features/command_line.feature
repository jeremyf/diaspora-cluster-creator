@announce
Feature: Provide tested examples of the command-line interface

Scenario: Specify no filename
  When I run `diaspora-cluster names="Sparta{T2 E-1 R0},Athens{T1 E1 R0}"`
  Then it should pass with:
  """
  graph Cluster {
    Sparta [label = "Sparta
  T2 R0 E-1"];
    Athens [label = "Athens
  T1 R0 E1"];
    Sparta -- Athens
  }
  """

Scenario: Specify no filename
  When I run `diaspora-cluster filename=cluster.dot`
  Then it should pass with:
  """
  """