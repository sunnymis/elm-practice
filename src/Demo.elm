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


type Msg
    = NameChange String
    | Save
    | FullTimeChecked
    | StudentChecked


update : Msg -> Model -> Model
update msg model =
    case msg of
        NameChange newName ->
            updateName model newName

        FullTimeChecked ->
            updateRadio msg model

        StudentChecked ->
            updateRadio msg model

        Save ->
            { model | employees = model.employee :: model.employees }


updateName : Model -> String -> Model
updateName model newName =
    let
        employee =
            model.employee

        newEmployee =
            { employee | name = newName }
    in
        { model | employee = newEmployee }


updateRadio : Msg -> Model -> Model
updateRadio msg model =
    case msg of
        FullTimeChecked ->
            let
                employee =
                    model.employee

                newEmployee =
                    { employee | employmentType = FullTime }
            in
                { model | employee = newEmployee }

        StudentChecked ->
            let
                employee =
                    model.employee

                newEmployee =
                    { employee | employmentType = Student }
            in
                { model | employee = newEmployee }

        _ ->
            model



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
            , (radio model FullTimeChecked FullTime "Full Time")
            , (radio model StudentChecked Student "Student")
            , button [ type_ "submit" ] [ text "SAVE" ]
            , ul [] (List.map employeeList model.employees)
            ]
        ]


radio : Model -> Msg -> EmploymentType -> String -> Html Msg
radio model msg et str =
    label []
        [ input
            [ type_ "radio"
            , name "employmentType"
            , onClick msg
            , checked (model.employee.employmentType == et)
            ]
            []
        , text str
        ]


employeeList : Employee -> Html Msg
employeeList employee =
    li []
        [ h2 [] [ text employee.name ]
        , h2 [] [ text employee.project ]
        , h2 [] [ text (toString employee.employmentType) ]
        ]
