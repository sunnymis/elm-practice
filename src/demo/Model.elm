module Model exposing (..)

{-| This is the model of the Demo app.

# Definition
@docs model

# Types
@docs Employee, Project, EmploymentType, Msg, Model
-}


{-| The Model
-}
type alias Model =
    { employee : Employee
    , project : Project
    , isEditing : Bool
    , uniqueID : Int
    , employees : List Employee
    , projects : List Project
    }


{-| Creates variable `model` to be of type Model, using the type constructor
-}
model : Model
model =
    Model
        (Employee 0 "" "" FullTime)
        (Project "" "")
        False
        0
        [ Employee 999 "Sunny" "PiggyBank" FullTime ]
        [ (Project "WhoZoo" "Simon")
        , (Project "CodePilot" "Ian")
        , (Project "PiggyBank" "Tom")
        , (Project "FreshTracks" "Matt")
        , (Project "KnowThings" "AK")
        ]


{-| An Employee
-}
type alias Employee =
    { id : Int
    , name : String
    , project : String
    , employmentType : EmploymentType
    }


{-| A Project
-}
type alias Project =
    { name : String
    , founder : String
    }


{-| A Union Type
-}
type EmploymentType
    = FullTime
    | Student


{-| Message / Action
-}
type Msg
    = NameChange String
    | Save
    | FullTimeChecked
    | StudentChecked
    | SelectProject String
    | Delete Employee
    | Edit Employee
