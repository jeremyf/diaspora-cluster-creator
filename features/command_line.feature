@announce
Feature: Provide tested examples of the command-line interface

Scenario: Specify without parameters
  When I run `diaspora-cluster`
  Then it should pass with output like:
  """
  graph Cluster {
    A \[label = "A
  T-?\d R-?\d E-?\d"\];
    B \[label = "B
  T-?\d R-?\d E-?\d"\];
    A -- B
  }
  """

Scenario: Specify with names
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

Scenario: Specify with technology guarantee
  When I run `diaspora-cluster names="Sparta{T0 E-1 R0},Athens{T1 E1 R0},Corinth{T1 E0 R0}"`
  Then it should pass with output like:
  """
  graph Cluster {
    Sparta \[label = "Sparta
  T2 R0 E-1"\];
    Athens \[label = "Athens
  T2 R0 E1"\];
    Corinth \[label = "Corinth
  T1 R0 E0"\];
    Sparta -- Athens
    Athens -- Corinth
  }
  """

Scenario: With -h
  When I run `diaspora-cluster -h`
  Then it should fail with output like:
  """
  NAME
    diaspora-cluster
  
  SYNOPSIS
    diaspora-cluster \[names=names\] \[count=count\] \[filename=filename\]
  
  DESCRIPTION
    Generate a diaspora cluster
  
  PARAMETERS
    names
    count
    filename
    --help, -h
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

Scenario: Specify different attributes
  When I run `diaspora-cluster attributes="Magic, Religion, Science"`
  Then it should pass with output like:
  """
  graph Cluster {
    A \[label = "A
  M-?\d R-?\d S-?\d"\];
    B \[label = "B
  M-?\d R-?\d S-?\d"\];
    C \[label = "C
  M-?\d R-?\d S-?\d"\];
    D \[label = "D
  M-?\d R-?\d S-?\d"\];
    E \[label = "E
  M-?\d R-?\d S-?\d"\];
    A -- B
    B -- C
    C -- D
    D -- E
  """

Scenario: Specify different attributes with prefix override
  When I run `diaspora-cluster attributes="M(a)gic, Religion, Science"`
  Then it should pass with output like:
  """
  graph Cluster {
    A \[label = "A
  A-?\d R-?\d S-?\d"\];
    B \[label = "B
  A-?\d R-?\d S-?\d"\];
    C \[label = "C
  A-?\d R-?\d S-?\d"\];
    D \[label = "D
  A-?\d R-?\d S-?\d"\];
    E \[label = "E
  A-?\d R-?\d S-?\d"\];
    A -- B
    B -- C
    C -- D
    D -- E
  """

@wip
Scenario: Specify different attributes with guarantee
  When I run `diaspora-cluster attributes="Knights,Dragons,Maidens" guarantee="2 Knights @ 2 and 2 Dragons @ -3" names="Sparta {K1},Athens {K1}"`
  Then it should pass with output like:
  """
  graph Cluster {
    Sparta \[label = "Sparta
  K2 D-3 M-?\d"\];
    Athens \[label = "Athens
  K2 D-3 M-?\d"\];
    Sparta -- Athens
  """
  
Scenario: Specify different attributes with default
  When I run `diaspora-cluster names="Sparta{M5},Athens{R-5}" attributes="Magic, Religion, Science"`
  Then it should pass with output like:
  """
  graph Cluster {
    Sparta \[label = "Sparta
  M5 R-?\d S-?\d"\];
    Athens \[label = "Athens
  M-?\d R-5 S-?\d"\];
    Sparta -- Athens
  """

Scenario: Specify with count parameters
  When I run `diaspora-cluster count=10`
  Then it should pass with output like:
  """
  graph Cluster {
    A \[label = "A
  T-?\d R-?\d E-?\d"\];
    B \[label = "B
  T-?\d R-?\d E-?\d"\];
    C \[label = "C
  T-?\d R-?\d E-?\d"\];
    D \[label = "D
  T-?\d R-?\d E-?\d"\];
    E \[label = "E
  T-?\d R-?\d E-?\d"\];
    F \[label = "F
  T-?\d R-?\d E-?\d"\];
    G \[label = "G
  T-?\d R-?\d E-?\d"\];
    H \[label = "H
  T-?\d R-?\d E-?\d"\];
    I \[label = "I
  T-?\d R-?\d E-?\d"\];
    J \[label = "J
  T-?\d R-?\d E-?\d"\];
    A -- B
    B -- C
    C -- D
    D -- E
    E -- F
    F -- G
    H -- I
    I -- J
  }
  """