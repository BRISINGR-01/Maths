port module Main exposing (..)
import Pythagoras exposing (run, InputType) 
import Platform.Cmd exposing (Cmd)
import Platform.Sub exposing (Sub)


type alias OutputType = String

port get : (InputType -> msg) -> Sub msg
port put : OutputType -> Cmd msg


main : Program Flags () Msg
main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }

type alias Model = ()
type Msg = Input InputType
type alias Flags = ()

init : Flags -> ( Model, Cmd Msg )
init _ =
    ( (), Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input input -> ( model, put (run input))


subscriptions : Model -> Sub Msg
subscriptions _ =
    get Input

{- Below is the input-to-output transformation.
   It could be anything.  Here we have something
   simple for demonstration purposes.
-}
