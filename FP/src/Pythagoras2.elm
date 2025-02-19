module Pythagoras2 exposing (InputType, run)


isTriple : Int -> Int -> Int -> Bool
isTriple a b c =
    sqr a + sqr b == sqr c


sqr : Int -> Int
sqr a =
    a * a


isNValid : Int -> Bool
isNValid n =
    if n < 1 then
        False

    else
        True


leg1 : Int -> Int -> Int
leg1 a b =
    let
        ( res, _, _ ) =
            pythTriple (Tuple.pair a b)
    in
    res


leg2 : Int -> Int -> Int
leg2 a b =
    let
        ( _, res, _ ) =
            pythTriple (Tuple.pair a b)
    in
    res


hyp : Int -> Int -> Int
hyp a b =
    let
        res =
            sqrt (toFloat (sqr a + sqr b))
    in
    if toFloat (round res) == res then
        round res

    else
        -1


pythTriple : ( Int, Int ) -> ( Int, Int, Int )
pythTriple d =
    let
        x =
            Tuple.first d

        y =
            Tuple.second d
    in
    ( sqr x - sqr y, 2 * y * x, sqr x + sqr y )



-- isTriple
---------------
-- type alias InputType = { a: Int , b: Int, c: Int }
-- run : InputType -> String
-- run input =
--     if not (isNValid input.a && isNValid input.b && isNValid input.c) then
--       "Bad input"
--     else if isTriple input.a input.b input.c then
--       "True"
--     else
--       "False"
-- leg1/2
-----------------
-- type alias InputType = { a: Int , b: Int }
-- run : InputType -> String
-- run input =
--     if not (isNValid input.a && isNValid input.b) then
--       "Bad input"
--     else
--       String.fromInt (hyp input.a input.b)
-- > pythTriplesMap [(5,4), (2,1), (35,7)]
-- [(9,40,41), (3,4,5), (1176,490,1274)]
-- > pythTriplesRec [(5,4), (2,1), (35,7)]
-- [(9,40,41), (3,4,5), (1176,490,1274)]
-- Write functions
-- arePythTriplesFilter: List (Int, Int, Int) -> List (Int, Int, Int)
-- arePythTriplesRec: List (Int, Int, Int) -> List (Int, Int, Int)
-- which removes all non-Pythagorean triples. Make two implementations: with List.filter
-- and recursively. Example:
-- > arePythTriplesRec [(1,2,3), (9,40,41), (3,4,5), (100,2,500)]
-- [(9,40,41), (3,4,5)]


type alias InputType =
    { a : Int, b : Int }


run : InputType -> String
run input =
    if input.a < input.b then
        "1st number cannot be smaller than the 2nd"

    else if not (isNValid input.a && isNValid input.b) then
        "Bad input"

    else
        let
            res =
                leg1 input.a input.b
        in
        String.fromInt res
