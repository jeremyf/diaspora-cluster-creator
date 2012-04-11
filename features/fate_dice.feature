Feature: Fudge dice

Scenario Outline: Rolling fudge dice
  When I roll <Dice>
  Then the result is between <Min> and <Max>
  
  Examples:
    | Dice  | Min | Max |
    | 1dF   | -1  | 1   |
    | 2dF   | -2  | 2   |
    | 3dF   | -3  | 3   |
    | 4dF   | -4  | 4   |
  