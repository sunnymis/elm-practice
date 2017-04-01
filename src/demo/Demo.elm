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
    { id : Int
    , name : String
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
    , isEditing : Bool
    , uniqueID : Int
    , employees : List Employee
    , projects : List Project
    }


model : Model
model =
    Model
        (Employee 0 "" "" FullTime)
        (Project "" "")
        False
        0
        []
        [ (Project "WhoZoo" "Simon")
        , (Project "CodePilot" "Ian")
        , (Project "PiggyBank" "Tom")
        , (Project "FreshTracks" "Matt")
        , (Project "KnowThings" "AK")
        ]



-- update


type Msg
    = NameChange String
    | Save
    | FullTimeChecked
    | StudentChecked
    | SelectProject String
    | Delete Employee
    | Edit Employee


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
            save model

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

        Delete employee ->
            let
                newEmployees =
                    List.filter (\e -> e.name /= employee.name) model.employees
            in
                { model | employees = newEmployees }

        Edit editEmployee ->
            { model | employee = editEmployee, isEditing = True }


save : Model -> Model
save model =
    if model.isEditing then
        let
            newEmployees =
                List.map
                    (\e ->
                        if e.id == model.employee.id then
                            { e
                                | name = model.employee.name
                                , project = model.employee.project
                                , employmentType = model.employee.employmentType
                            }
                        else
                            e
                    )
                    model.employees
        in
            { model
                | employees = newEmployees
                , isEditing = False
                , employee = Employee 0 "" "" FullTime
                , project = Project "" ""
            }
    else
        let
            employee =
                model.employee

            newEmployee =
                { employee | id = model.uniqueID }
        in
            { model
                | employees = newEmployee :: model.employees
                , employee = Employee 0 "" "" FullTime
                , project = Project "" ""
                , uniqueID = model.uniqueID + 1
            }


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
    div [ class "container" ]
        [ Html.form [ onSubmit Save ]
            [ h2 [ class "ui header" ] [ text "Edit Employees" ]
            , input
                [ class "input-field"
                , placeholder "Name"
                , value model.employee.name
                , onInput NameChange
                ]
                []
            , select
                [ class "ui search selection dropdown"
                , id "select"
                , onInput SelectProject
                ]
                (model.projects
                    |> List.sortBy .name
                    |> List.map (projectView model)
                    |> addDefaultSelect model
                )
            , div [ class "radio-controls" ]
                [ (radioView model FullTimeChecked "Full Time" FullTime)
                , (radioView model StudentChecked "Student" Student)
                ]
            , button [ class "ui primary button", id "save", type_ "submit" ] [ text "SAVE" ]
            , table [] (employeeListHeader :: (List.map employeeList model.employees))
            ]
        ]


addDefaultSelect : Model -> List (Html Msg) -> List (Html Msg)
addDefaultSelect model projectList =
    let
        default =
            option [ value "", selected (model.project.name == "") ] [ text "Select Project" ]
    in
        default :: projectList


projectView : Model -> Project -> Html Msg
projectView model project =
    option [ value project.name, selected (model.employee.project == project.name) ] [ text project.name ]


radioView : Model -> Msg -> String -> EmploymentType -> Html Msg
radioView model msg str et =
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


employeeListHeader : Html Msg
employeeListHeader =
    tr []
        [ th [] [ text "Employee" ]
        , th [] [ text "Project" ]
        , th [] [ text "Employment Type" ]
        ]


employeeList : Employee -> Html Msg
employeeList employee =
    tr []
        [ td [] [ text employee.name ]
        , td [] [ text employee.project ]
        , td [] [ text (toString employee.employmentType) ]
        , td [ onClick (Delete employee) ] [ text "Delete" ]
        , td [ onClick (Edit employee) ] [ text "Edit" ]
        ]
