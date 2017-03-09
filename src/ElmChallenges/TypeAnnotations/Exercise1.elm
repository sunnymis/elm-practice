module TypeAnnotations exposing (..)

import Html


type alias CartItem =
    { name : String
    , qty : Int
    , freeQty : Int
    }


cart : List CartItem
cart =
    [ { name = "Lemon", qty = 1, freeQty = 0 }
    , { name = "Apple", qty = 5, freeQty = 0 }
    , { name = "Pear", qty = 10, freeQty = 0 }
    ]


setFreeQty : Int -> Int -> CartItem -> CartItem
setFreeQty minQty numFree item =
    if item.qty >= minQty && item.freeQty == 0 then
        { item | freeQty = numFree }
    else
        item


main : Html.Html msg
main =
    List.map ((setFreeQty 10 3) >> (setFreeQty 5 1)) cart
        |> toString
        |> Html.text
