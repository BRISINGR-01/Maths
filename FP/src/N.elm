module N exposing (..)

import Debug exposing (toString)


type alias InputType =
    Int


calc3 : Int -> Int
calc3 n =
    if n == 0 then
        1

    else
        3 * calc3 (n - 1)


sq : Int -> Int
sq n =
    if n == 0 then
        0

    else
        n * n + sq (n - 1)


run : InputType -> String
run input =
    if input < 0 then
        "Bad Input"

    else
        toString <| sq input
