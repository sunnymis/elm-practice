module FetchGif exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http exposing (..)
import Json.Decode exposing (..)
import Debug exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- model


type alias Model =
    { topic : String
    , gifUrl : String
    }


type Msg
    = MorePlease
    | NewGif (Result Http.Error String)


init : ( Model, Cmd Msg )
init =
    ( Model "Cats" "waiting.gif", Cmd.none )


type alias RandomUser =
    { gender : String
    , picture : Picture
    }


type alias Picture =
    { large : String
    , medium : String
    , thumbnail : String
    }



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            ( model, getRandomGif model.topic )

        NewGif retVal ->
            case (log "retVal" retVal) of
                Ok newUrl ->
                    ( { model | gifUrl = newUrl }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text model.topic ]
        , img [ src model.gifUrl ] []
        , button [ onClick MorePlease ] [ text "More Please!" ]
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


decodePicture : Decoder Picture
decodePicture =
    object2 Picture
        ("large" := string)
        ("medium" := string)
        ("thumbnail" := string)


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://randomuser.me/api/"

        request =
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "results", "picture" ] Decode.string
