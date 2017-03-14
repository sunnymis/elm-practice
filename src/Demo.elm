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


type alias Project =
    { name : String
    , founder : String
    }


type alias Model =
    { employee : Employee
    , project : Project
    , employees : List Employee
    , projects : List Project
    }


model : Model
model =
    Model (Employee "" "" FullTime) (Project "" "") [] [ (Project "WhoZoo" "Simon"), (Project "CodePilot" "Ian"), (Project "PiggyBank" "Tom"), (Project "FreshTracks" "Matt"), (Project "KnowThings" "AK") ]



-- update


type Msg
    = NameChange String
    | Save
    | FullTimeChecked
    | StudentChecked
    | SelectProject String


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
            { model | employees = model.employee :: model.employees, employee = Employee "" "" FullTime, project = Project "" "" }

        SelectProject selectedProject ->
            let
                newProject =
                    model.projects
                        |> List.filter (\p -> p.name == selectedProject)
                        |> List.head
                        |> resolveProject

                employee =
                    model.employee

                newEmployee =
                    { employee | project = newProject.name }
            in
                { model | project = newProject, employee = newEmployee }


resolveProject : Maybe Project -> Project
resolveProject project =
    case project of
        Nothing ->
            Project "" ""

        Just proj ->
            proj


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
            , select [ onInput SelectProject ]
                (model.projects
                    |> List.sortBy .name
                    |> List.map projectView
                    |> addDefaultSelect model
                )
            , (radioView FullTimeChecked "Full Time")
            , (radioView StudentChecked "Student")
            , button [ type_ "submit" ] [ text "SAVE" ]
            , ul [] (List.map employeeList model.employees)
            ]
        ]


addDefaultSelect : Model -> List (Html Msg) -> List (Html Msg)
addDefaultSelect model projectList =
    let
        default =
            option [ value "", selected (model.project.name == "") ] [ text "Select Project" ]
    in
        default :: projectList


projectView : Project -> Html Msg
projectView project =
    option [ value project.name ] [ text project.name ]


radioView : Msg -> String -> Html Msg
radioView msg str =
    label []
        [ input
            [ type_ "radio"
            , name "employmentType"
            , onClick msg
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
