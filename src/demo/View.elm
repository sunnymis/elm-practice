module View exposing (view)

{-| The view for the Demo app.

# Definition
@docs view

-}

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


{-| Creates the root view from the model

    view {employee = ..., project = ..., isEditing = ...}
-}
view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ Html.form
            [ onSubmit Save ]
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
            , button
                [ class "ui primary button"
                , id "save"
                , type_ "submit"
                ]
                [ text "SAVE" ]
            , table [] (employeeListHeader :: (List.map employeeList model.employees))
            ]
        ]


{-| Returns an select option
-}
projectView : Model -> Project -> Html Msg
projectView model project =
    option
        [ value project.name
        , selected (model.employee.project == project.name)
        ]
        [ text project.name ]


{-| Adds a default selection option to the select dropdown
-}
addDefaultSelect : Model -> List (Html Msg) -> List (Html Msg)
addDefaultSelect model projectList =
    let
        default =
            option
                [ value ""
                , selected (model.project.name == "")
                ]
                [ text "Select Project" ]
    in
        default :: projectList


{-| Creates a radio element
-}
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


{-| Adds a header row to the table
-}
employeeListHeader : Html Msg
employeeListHeader =
    tr []
        [ th [] [ text "Employee" ]
        , th [] [ text "Project" ]
        , th [] [ text "Employment Type" ]
        , th [] [ text "dsf" ]
        , th [] [ text "dsf" ]
        ]


{-| Adds a row to the table
-}
employeeList : Employee -> Html Msg
employeeList employee =
    tr []
        [ td [] [ text employee.name ]
        , td [] [ text employee.project ]
        , td [] [ text (toString employee.employmentType) ]
        , td [ onClick (Delete employee) ] [ text "Delete" ]
        , td [ onClick (Edit employee) ] [ text "Edit" ]
        ]
