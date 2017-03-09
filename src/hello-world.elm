module Main exposing (..)

import Html exposing (text)


add : number -> number -> number
add a b =
    a + b


add3 : number -> number
add3 n =
    add 5 n


result : number
result =
    add 1 2 |> add 5


resultAnon : Bool
resultAnon =
    add 4 2 |> \n -> n % 2 == 0


counter : number
counter =
    0


increment : number -> number -> number
increment cnt amt =
    cnt + amt


localVariables : number -> number -> number
localVariables cnt amt =
    let
        count =
            cnt
    in
        count + amt


main : Html.Html msg
main =
    --Html.text (toString result)
    Html.text (toString resultAnon)
