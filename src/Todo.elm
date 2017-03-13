module Todo exposing (..)

import Html exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- model


type alias Model =
    { todos : List Todo
    , filteredTodos : List Todo
    }


type alias Todo =
    { task : String
    , completed : Bool
    }


type Msg
    = All
    | Active
    | Completed


init : ( Model, Cmd Msg )
init =
    ( Model
        [ (Todo "Lift" False)
        , (Todo "Eat" True)
        , (Todo "Sleep" False)
        , (Todo "Code" True)
        ]
        [ (Todo "Lift" False)
        , (Todo "Eat" True)
        , (Todo "Sleep" False)
        , (Todo "Code" True)
        ]
    , Cmd.none
    )



-- update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        All ->
            ( { model | filteredTodos = model.todos }, Cmd.none )

        Active ->
            ( { model | filteredTodos = (List.filter (\t -> t.completed == False) model.todos) }, Cmd.none )

        Completed ->
            ( { model | filteredTodos = (List.filter (\t -> t.completed == True) model.todos) }, Cmd.none )



-- view


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick All ] [ text "All" ]
        , button [ onClick Active ] [ text "Active" ]
        , button [ onClick Completed ] [ text "Completed" ]
        , div [] (List.map viewTodo model.filteredTodos)
        ]


viewTodo : Todo -> Html Msg
viewTodo todo =
    h1 [] [ text todo.task ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
