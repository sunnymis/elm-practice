module Demo exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- model


type EmploymentType
    = FullTime
    | Student


type Msg
    = NameChange String
    | Save


type alias Employee =
    { name : String
    , project : String
    , employmentType : EmploymentType
    }


type alias Model =
    { employee : Employee
    , employees : List Employee
    }


model : Model
model =
    Model (Employee "" "" FullTime) []



-- update


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameChange newName ->
            updateName model newName

        Save ->
            model


updateName : Model -> String -> Model
updateName model newName =
    let
        employee =
            model.employee

        newEmployee =
            { employee | name = newName }
    in
        { model | employee = newEmployee }



-- view


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit Save ]
            [ input
                [ placeholder "Name"
                , value model.employee.name
                , onInput NameChange
                ]
                []
            , (checkbox model "Full Time")
            , (checkbox model "Student")
            , button [ type_ "submit" ] [ text "SAVE" ]
            ]
        ]


checkbox : Model -> String -> Html Msg
checkbox model str =
    label []
        [ input
            [ type_ "checkbox"
            ]
            []
        , text str
        ]
