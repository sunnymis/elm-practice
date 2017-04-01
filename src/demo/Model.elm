module Model exposing (..)

{-| This library fills a bunch of important niches in Elm. A `Maybe` can help
you with optional arguments, error handling, and records with optional fields.

# Definition
@docs model

# Types
@docs EmploymentType, Employee, Project, Model, Msg
-}


{-| A model

    model ['e','l','m'] == "elm"
-}
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


{-| A model

    employmenttype
-}
type EmploymentType
    = FullTime
    | Student


{-| Employee

    employee
-}
type alias Employee =
    { id : Int
    , name : String
    , project : String
    , employmentType : EmploymentType
    }


{-| Employment type

    employmenttype
-}
type alias Project =
    { name : String
    , founder : String
    }


{-| Employment type

    employmenttype
-}
type alias Model =
    { employee : Employee
    , project : Project
    , isEditing : Bool
    , uniqueID : Int
    , employees : List Employee
    , projects : List Project
    }


{-| Employment type

    employmenttype
-}
type Msg
    = NameChange String
    | Save
    | FullTimeChecked
    | StudentChecked
    | SelectProject String
    | Delete Employee
    | Edit Employee
