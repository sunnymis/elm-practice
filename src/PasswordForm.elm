module PasswordForm exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { name : String
    , password : String
    , verifyPassword : String
    }


type Msg
    = NameChange String
    | PasswordChange String
    | VerfiyPasswordChange String


model : Model
model =
    { name = ""
    , password = ""
    , verifyPassword = ""
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameChange newName ->
            { model | name = newName }

        PasswordChange newPassword ->
            { model | password = newPassword }

        VerfiyPasswordChange newVerifiedPassword ->
            { model | verifyPassword = newVerifiedPassword }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Name", onInput NameChange ] []
        , input [ type_ "password", placeholder "Password", onInput PasswordChange ] []
        , input [ type_ "password", placeholder "Verify Password", onInput VerfiyPasswordChange ] []
        , div [] [ text (message model) ]
        ]


validate : String -> Bool
validate str =
    if (String.isEmpty str) then
        False
    else
        True


getVerificationText : Model -> String
getVerificationText model =
    if model.password == model.verifyPassword then
        "Success! Password confirmed."
    else
        "Error! Passwords do not match."


message : Model -> String
message model =
    if (validate model.password && validate model.verifyPassword) then
        getVerificationText model
    else
        ""
