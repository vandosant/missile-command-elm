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


type alias Model =
  { score : Int
  , x : Float
  , y : Float
  , velocity : Float
  }


model : Model

model =
  { score = 0
  , x = 0
  , y = 0
  , velocity = 0.2
  }

init : (Model, Cmd Msg)
init =
  (model, Cmd.none)


-- UPDATE


type Msg =
  Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg ({score, x, y, velocity} as model) =
  case msg of
    Tick newTime ->
      ({ model | y = y + velocity, x = x + velocity }, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every millisecond Tick




-- VIEW


view : Model -> Html Msg
view model =
  svg [ viewBox "0 0 100 100", width "300px" ]
    [ rect [ x "0", y "0", width "100", height "100", fill "#ceecee" ] []
    , rect [ x (toString model.x), y (toString model.y), width "1", height "1", fill "#000" ] []
    ]
