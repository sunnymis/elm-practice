module Demo exposing (..)

import Html exposing (..)


--import Html.Events exposing (..)

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
    = Save


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
    model



-- view


view : Model -> Html Msg
view model =
    div []
        [ Html.form []
            [ input
                [ placeholder "Name"
                , value model.employee.name
                ]
                []
            , (checkbox model "Full Time")
            , (checkbox model "Student")
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
