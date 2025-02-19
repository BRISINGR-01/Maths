module Ceasar exposing (run, InputType)
import Char exposing (isLower)

upStart = Char.toCode 'A'
upEnd = Char.toCode 'Z'
lowStart = Char.toCode 'a'
lowEnd = Char.toCode 'z'

calcOffset: Int -> Char -> Int
calcOffset offset c =
   let
       chAsInt = Char.toCode c
       validOffset = modBy offset 26
   in
   
   if isLower c then
      calcLowerOffset validOffset chAsInt
   else 
      calcUpperOffset validOffset chAsInt

calcLowerOffset: Int -> Int -> Int
calcLowerOffset offset c =
   let sum = c + offset in
   if sum < lowEnd then
      offset
   else 
      sum - lowEnd + upStart

calcUpperOffset: Int -> Int -> Int
calcUpperOffset offset c =
   let sum = c + offset in
   if sum < upEnd then
      offset
   else 
      sum - upEnd + lowStart


charEncode: Int -> Char -> Char
charEncode offset c =
   if Char.isAlpha c then
      Char.fromCode (Char.toCode c + (calcOffset offset c))
   else
      c

encode: Int -> String -> String
encode offset c =
   String.map (\ch -> charEncode offset ch) c

decode: Int -> String -> String
decode offset c =
   encode (26 - offset) c

type alias InputType = { offset: Int , val: String }

run : InputType -> String
run input =
    encode input.offset input.val