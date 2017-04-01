module View exposing (view)

{-| This library fills a bunch of important niches in Elm. A `Maybe` can help
you with optional arguments, error handling, and records with optional fields.

# Definition
@docs view

-}

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)


{-| Convert a list of characters into a String. Can be useful if you
want to create a string primarly by consing, perhaps for decoding
something.

    view ['e','l','m'] == "elm"
-}
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
