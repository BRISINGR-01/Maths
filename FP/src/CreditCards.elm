module CreditCards exposing (..)

isValid: String -> Bool
isValid num =
  (num
    |> toIntList
    |> reverse
    |> List.filter (\n -> n >= 0)
    |> calcCheckSum
    |> toIntList
    |> List.foldl (+) 0
    |> modBy 10
  ) == 0

reverse: List Int -> List Int
reverse list =
   case list of
        [] -> []
        x :: xs -> List.append (reverse xs) [x]

calcCheckSum: List Int -> String
calcCheckSum list =
  let
      head = case List.head list of
          Nothing -> 0
          Just n -> n
  in
    case List.tail list of
        Nothing -> ""
        Just rest ->
          if (List.length list |> modBy 2) == 1 then
            String.fromInt (head*2) ++ calcCheckSum rest
          else
            String.fromInt head ++ calcCheckSum rest

toIntList: String -> List Int
toIntList list =
  list
    |> String.split ""
    |> List.map (\c -> 
      case String.toInt c of
        Nothing -> -1
        Just x -> x
    )

isInputValid: String -> Bool
isInputValid num =
  num 
    |> toIntList
    |> List.all (\n -> n >= 0)

type alias InputType = String
run : InputType -> String
run input =
  if String.isEmpty input then
    "Empty input"
  else if not <| isInputValid input then
    "Bad input"
  else if isValid input then
    "Correct"
  else
    "Invalid"
