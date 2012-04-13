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

Scenario: Specify without parameters
  When I run `diaspora-cluster`
  Then it should pass with output like:
  """
  graph Cluster {
    A \[label = "A\nT-?\d R-?\d E-?\d"\];
    B \[label = "B\nT-?\d R-?\d E-?\d"\];
    A -- B
  }
  """
  

Scenario Outline: I want files of different formats
  When I run `diaspora-cluster filename=cluster.<FORMAT>`
  Then the following files should exist:
    | cluster.<FORMAT> |
  
  Examples:
  | FORMAT |
  | png    |
  | dot    |
  | svg    |
  
Scenario: With -h
  When I run `diaspora-cluster -h`
  Then it should fail with regex:
  """
  DESCRIPTION\n\s*Generate a diaspora cluster
  """
