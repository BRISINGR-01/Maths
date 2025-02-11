module Pythagoras exposing (run, InputType)
import Array exposing (Array)



isTriple: Int -> Int -> Int -> Bool
isTriple a b c =
  (sqr a) + (sqr b) == (sqr c)

sqr: Int -> Int
sqr a =
  a * a

isNValid: Int -> Bool
isNValid n =
  if n < 1 then
   False
  else 
    True


leg1 : Int -> Int -> Int
leg1 a b =
  let 
    (res, _, _) = pythTriple (Tuple.pair a b)
  in
  res

leg2 : Int -> Int -> Int
leg2 a b =
  let 
    (_, res, _) = pythTriple (Tuple.pair a b)
  in
  res


hyp : Int -> Int -> Int
hyp a b =
  (sqr a) + (sqr b)

pythTriple : (Int, Int) -> (Int, Int, Int)
pythTriple d =
  let 
    x = Tuple.first d
    y = Tuple.second d
  in

  ((sqr x) - (sqr y), 2 * y * x, (sqr x) + (sqr y))


-- isTriple
-----------------
-- type alias InputType = { a: Int , b: Int, c: Int }
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
-- run input =
--     if not (isNValid input.a && isNValid input.b) then
--       "Bad input"
--     else 
--       String.fromInt (leg1 input.a input.b)

type alias InputType = { a: Int , b: Int }
run : InputType -> String
run input =
    if not (isNValid input.a && isNValid input.b) then
      "Bad input"
    else 
      String.fromInt (leg1 input.a input.b)
    