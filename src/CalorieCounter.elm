module CalorieCounter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- Model


type alias Model =
    { calories : Int
    , input : Int
    , error : Maybe String
    }


model : Model
model =
    Model 0 0 Nothing



-- Update


type Msg
    = AddCalorie
    | Clear
    | Input String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            let
                currCalories =
                    model.calories
            in
                if model.input == 0 then
                    { model | calories = currCalories + 1 }
                else
                    { model
                        | calories = currCalories + model.input
                        , input = 0
                    }

        Clear ->
            model

        Input val ->
            case String.toInt val of
                Ok input ->
                    { model
                        | input = input
                        , error = Nothing
                    }

                Err err ->
                    { model
                        | input = 0
                        , error = Just err
                    }



-- View


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h3 []
            [ text ("Total CaloriesL " ++ (toString model.calories)) ]
        , input
            [ type_ "text"
            , onInput Input
            , value
                (if model.input == 0 then
                    ""
                 else
                    toString model.input
                )
            ]
            []
        , div [] [ text (Maybe.withDefault "" model.error) ]
        , button
            [ type_ "button"
            , onClick AddCalorie
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
