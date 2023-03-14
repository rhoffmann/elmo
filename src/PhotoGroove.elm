module PhotoGroove exposing (main)

import Array exposing (Array)
import Browser
import Html exposing (Html, button, div, h1, img, select, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


type ThumbnailSize
    = Small
    | Medium
    | Large


type alias Photo =
    { id : String, url : String }


type alias Model =
    { photos : List Photo, selectedPhotoId : String }


type alias Msg =
    { description : String
    , data : String
    }


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedId thumb =
    img [ src (urlPrefix ++ thumb.url), classList [ ( "selected", selectedId == thumb.id ) ], onClick { description = "PHOTO_CLICKED", data = thumb.id } ] []


findById : List { a | id : String } -> String -> Maybe { a | id : String }
findById list id =
    List.head (List.filter (\item -> item.id == id) list)


maybeSelectedImage : List Photo -> String -> Html Msg
maybeSelectedImage photos selectedId =
    case findById photos selectedId of
        Just photo ->
            img [ class "large", src (urlPrefix ++ "large/" ++ photo.url) ] []

        Nothing ->
            div [] []


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "PhotoGroove" ]
        , button
            [ onClick { description = "SURPRISE_ME_CLICKED", data = "" } ]
            [ text "Surprise Me!" ]
        , div [ id "thumbnails" ] (List.map (viewThumbnail model.selectedPhotoId) model.photos)
        , maybeSelectedImage model.photos model.selectedPhotoId
        ]


initialModel : Model
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
        , { id = "4"
          , url = "4.jpeg"
          }
        , { id = "5"
          , url = "5.jpeg"
          }
        , { id = "6"
          , url = "6.jpeg"
          }
        ]
    , selectedPhotoId = "1"
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos


update : Msg -> Model -> Model
update msg model =
    case msg.description of
        "PHOTO_CLICKED" ->
            { model | selectedPhotoId = msg.data }

        "SURPRISE_ME_CLICKED" ->
            { model | selectedPhotoId = "2" }

        _ ->
            model


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
