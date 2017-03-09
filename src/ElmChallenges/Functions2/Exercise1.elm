module Fn2Exercise1 exposing (..)

import Html exposing (..)
import String exposing (slice, split)


(~=) : String -> String -> Bool
(~=) str1 str2 =
    (slice 0 1 str1) == (slice 0 1 str2)


getWords : String -> List String
getWords sentence =
    split " " sentence


getCount : List a -> Int
getCount list =
    List.length list


wordCount : String -> Int
wordCount =
    getWords >> getCount


main : Html msg
main =
    Html.text (toString (wordCount "Hello World"))



--Html.text (toString ("Sunny" ~= "Mistry"))
-- Infix
-- Prefix
--Html.text (toString ((~=) "Sunny" "SMistry")) -- Prefix
