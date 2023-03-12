module PhotoGroove exposing (main)

import Browser
import Html exposing (div, h1, img, select, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


viewThumbnail selectedId thumb =
    img [ src (urlPrefix ++ thumb.url), classList [ ( "selected", selectedId == thumb.id ) ], onClick { description = "PHOTO_CLICKED", data = thumb.id } ] []


findById list id =
    List.head (List.filter (\item -> item.id == id) list)


maybeSelectedImage photos selectedId =
    case findById photos selectedId of
        Just photo ->
            img [ class "large", src (urlPrefix ++ "large/" ++ photo.url) ] []

        Nothing ->
            div [] []


view model =
    div [ class "content" ]
        [ h1 [] [ text "PhotoGroove" ]
        , div [ id "thumbnails" ] (List.map (viewThumbnail model.selectedPhotoId) model.photos)
        , maybeSelectedImage model.photos model.selectedPhotoId
        ]


initialModel =
    { photos =
        [ { id = "1"
          , url = "1.jpeg"
          }
        , { id = "2"
          , url = "2.jpeg"
          }
        , { id = "3"
          , url = "3.jpeg"
          }
        ]
    , selectedPhotoId = "1"
    }


update msg model =
    if msg.description == "PHOTO_CLICKED" then
        { model | selectedPhotoId = msg.data }

    else
        model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
