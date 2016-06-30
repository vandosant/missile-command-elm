module Main exposing (..)

import ElmTest exposing (..)


tests : Test
tests =
  suite "Missile Command Tests"
    [ test "Are Working" 
        <| assertEqual (1 + 1) 2 
    ]


main =
  runSuite tests
