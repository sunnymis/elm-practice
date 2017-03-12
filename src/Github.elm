module Github exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)
import Http exposing (..)
import Json.Decode as Decode


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
    { githubAvatarUrl : String
    }


type Msg
    = GetData
    | ReceivedData (Result Http.Error String)


init : ( Model, Cmd Msg )
init =
    ( Model "", Cmd.none )



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetData ->
            ( model, getGithubData )

        ReceivedData data ->
            case data of
                Ok val ->
                    ( { model | githubAvatarUrl = val }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick GetData ] [ text "Get Data" ]
        , img [ src model.githubAvatarUrl ] []
        ]



--subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getGithubData : Cmd Msg
getGithubData =
    let
        url =
            "https://api.github.com/users/sunnymis"

        request =
            Http.get url decodeData
    in
        Http.send ReceivedData request


decodeData : Decode.Decoder String
decodeData =
    Decode.at [ "avatar_url" ] Decode.string
