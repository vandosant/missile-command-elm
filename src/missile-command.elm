import Html exposing (Html)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, millisecond)




main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }





-- MODEL


type alias IndexedMissile =
  { x : Float
  , y : Float
  , velocity : Float
  }


type alias Model =
  { score : Int
  , missiles : IndexedMissile
  }


indexedMissile : IndexedMissile

indexedMissile =
  { x = 0
  , y = 0
  , velocity = 0.3
  }


model : Model

model =
  { score = 0
  , missiles = indexedMissile
  }


init : (Model, Cmd Msg)
init =
  (model, Cmd.none)


-- UPDATE


type Msg =
  Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg ({score, missiles} as model) =
  case msg of
    Tick newTime ->
      ({ model | missiles = {x = missiles.x + missiles.velocity
      , y = missiles.y + missiles.velocity
      , velocity = missiles.velocity } }, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every millisecond Tick




-- VIEW


view : Model -> Html Msg
view ({missiles, score} as model) =
  svg [ viewBox "0 0 100 100", width "300px" ]
    [ rect [ x "0", y "0", width "100", height "100", fill "#ceecee" ] []
    , rect [ x (toString missiles.x), y (toString missiles.y), width "1", height "1", fill "#000" ] []
    ]
