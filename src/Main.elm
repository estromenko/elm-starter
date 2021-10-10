module Main exposing (main)

import Browser
import Browser.Navigation
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Url


type alias Model =
    String


type Msg
    = OnUrlChange Url.Url
    | OnUrlRequest Browser.UrlRequest


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd msg )
init _ _ _ =
    ( "", Cmd.none )


update : Msg -> Model -> ( Model, Cmd msg )
update msg _ =
    case msg of
        OnUrlChange url ->
            ( url.path, Cmd.none )

        OnUrlRequest request ->
            case request of
                Browser.Internal url ->
                    ( url.path, Cmd.none )

                Browser.External url ->
                    ( url, Browser.Navigation.load url )


body : Model -> Html Msg
body _ =
    div []
        [ text "Ok"
        ]


view : Model -> Browser.Document Msg
view model =
    { title = model
    , body = [ body model |> toUnstyled ]
    }


onUrlChange : Url.Url -> Msg
onUrlChange url =
    OnUrlChange url


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest request =
    OnUrlRequest request


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        , subscriptions = subscriptions
        }
