module MergeSort exposing (..)

msort: List comparable -> List comparable 
msort list = 
  case list of
    [] -> []
    [el] -> [el]
    _ -> 
      merge
        (list |> List.take (List.length list // 2) |> msort)
        (list |> List.reverse |> List.take ((List.length list + 1) // 2) |> msort)

merge: List comparable -> List comparable -> List comparable
merge a b =
  case a of
    [] -> b
    aHead::aRest -> case b of
      [] -> a
      bHead::bRest ->
        if aHead < bHead then
          aHead::merge aRest b
        else
          bHead::merge a bRest

type alias InputType = String
run: InputType -> String
run input =
  if String.isEmpty input then
    "Empty input"
  else
    String.split "," input
      |> List.map (\d -> case String.toInt d of
        Nothing -> -1
        Just res -> res
      )
      |> List.filter (\d -> d >= 0)
      |> msort
      |> List.map String.fromInt
      |> String.join ", "
