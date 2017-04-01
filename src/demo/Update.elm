module Update exposing (update)

{-| This library fills a bunch of important niches in Elm. A `Maybe` can help
you with optional arguments, error handling, and records with optional fields.

# Definition
@docs update

-}

import Model exposing (..)


{-| An update

    update ['e','l','m'] == "elm"
-}
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
