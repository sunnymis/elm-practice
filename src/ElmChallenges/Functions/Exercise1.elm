module Src.ElmChallenges.Functions.Exercise1 exposing (..)

import Html exposing (..)
import String exposing (length, toUpper)


upperCase : String -> String
upperCase name =
    if String.length name > 10 then
        String.toUpper name
    else
        name


formatText : String -> String
formatText name =
    let
        len =
            toString (String.length name)
    in
        name ++ " - name length: " ++ len


main : Html msg
main =
    --Html.text "Sunny Mistry" -- Exercise1
    upperCase "Sunny Mistry"
        |> formatText
        |> Html.text



-- Exercise2
