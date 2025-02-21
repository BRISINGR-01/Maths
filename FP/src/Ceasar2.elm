module Ceasar2 exposing (InputType, run)

import Html exposing (a)
import Regex
import Bounds exposing (Bounds)
import Bounds exposing (boundsList)

-- Algorithm

encode : Int -> String -> String
encode offset str =
    userReplace "[a-zA-Zа-яА-ЯΑ-Ωα-ω]+" (.match >> String.map (shiftChar offset)) str

encodeRec : Int -> Int -> String -> String
encodeRec i offset str =
    let
        len = String.length str
        nextI = i + 1
        encoder = String.join "" >> encodeRec nextI offset
        tail = String.slice nextI len str
        ch = case at nextI <| String.toList str of
                Nothing -> ' '
                Just a -> a
        nextChar = shiftChar offset ch |> String.fromChar
    in
    if i < 0 || i >= len then
        str
    else if i == 0 then
        [ nextChar, tail ] |> encoder
    else
        [ String.slice 0 i str, nextChar, tail ] |> encoder

-- Utils

shiftChar : Int -> Char -> Char
shiftChar offset c =
    case findBounds c of
        Nothing -> c
        Just bounds ->
            let sum = Char.toCode c + (offset |> remainderBy (bounds.thisEnd - bounds.thisStart)) in
            Char.fromCode <| 
            if sum < bounds.thisStart then
                sum - bounds.thisStart + bounds.otherEnd + 1
            else if sum <= bounds.thisEnd then
                sum
            else
                sum - bounds.thisEnd + bounds.otherStart - 1

findBounds : Char -> Maybe Bounds
findBounds c =
    let 
        ci = Char.toCode c 
    in
        List.head 
            <| List.filter 
                (\bounds -> ci >= bounds.thisStart && ci <= bounds.thisEnd) 
                boundsList

-- General Utils

userReplace : String -> (Regex.Match -> String) -> String -> String
userReplace userRegex replacer string =
    case Regex.fromString userRegex of
        Nothing -> string
        Just regex -> Regex.replace regex replacer string

at : Int -> List a -> Maybe a
at i list =
    if i > List.length list || i < 0 then
        Nothing
    else
        List.take i list
            |> List.reverse
            |> List.head

-- Other algorithms

decode : Int -> String -> String
decode offset c =
    encode (offset * -1) c

normalize : String -> String
normalize s =
    userReplace "\\W" (\_ -> "") s

type alias InputType =
    { offset : Int, val : String }

run : InputType -> String
run input =
    let n = input.offset in
    -- normalize input.val
    -- encodeRec 0 n input.val
    encode n input.val
    -- decode n input.val
    -- decode n (encode n input.val)
