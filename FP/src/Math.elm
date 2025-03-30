module Math exposing (..)

type Function
  = Poly  Function Int
  | Mult  Function Function
  | Div   Function Function
  | Plus  Function Function
  | Minus Function Function 
  | Const Int
  | X

print: Function -> String
print f =
  case f of
    X -> "x"
    Const x -> String.fromInt x
    Minus l r -> "(" ++ (print l) ++ " - " ++ (print r) ++ ")"
    Plus l r -> "(" ++ (print l) ++ " + " ++ (print r) ++ ")"
    Mult l r -> "(" ++ (print l) ++ " * " ++ (print r) ++ ")"
    Div l r -> "(" ++ (print l) ++ " / " ++ (print r) ++ ")"
    Poly fx i -> (print fx) ++ "^" ++ (String.fromInt i)

eval: Float -> Function -> Float 
eval x f = 
  case f of
    X -> x
    Const val -> Basics.toFloat val
    Minus l r -> (eval x l) - (eval x r)
    Plus l r -> (eval x l) + (eval x r)
    Mult l r -> (eval x l) * (eval x r)
    Div l r -> (eval x l) / (eval x r)
    Poly fx i -> (eval x fx) ^ (Basics.toFloat i)

-- graph: Function -> Int -> Int -> Int -> Int -> String
-- graph f a b c d =
  

type alias InputType = Float
run: InputType -> String
run input =
  let
    p0 = Plus X (Const 3)
    p1 = Poly p0 5
    p2 = Mult (Plus X (Const -2)) p1
    p3 = Plus (Plus (Minus p0 (Poly (Plus X (Const 5)) 7)) (Mult p0 (Div p2 X))) (Mult (Plus X X) X)
  in
    eval input p3 |> String.fromFloat