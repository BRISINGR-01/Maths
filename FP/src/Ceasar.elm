module Ceasar exposing (run, InputType)

validateNum: Int -> Int
validateNum n =
    modBy 26 (abs n)

charEncode: Int -> Char -> Char
charEncode n c =
  Char.fromCode (Char.toCode c + (validateNum n))

encode: Int -> String -> String
encode n c =
   String.map (\ch -> charEncode n ch) c

decode: Int -> String -> String
decode n c =
   encode (26 - n) c

type alias InputType = { n: Int , val: String }

run : InputType -> String
run input =
    encode input.n input.val