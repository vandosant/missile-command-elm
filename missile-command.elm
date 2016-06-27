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
  , x : Int
  , y : Int
  }


model : Model

model =
  { score = 0
  , x = 0
  , y = 0
  }

init : (Model, Cmd Msg)
init =
  (model, Cmd.none)


-- UPDATE


type Msg =
  Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg ({score, x, y} as model) =
  case msg of
    Tick newTime ->
      ({ model | y = y + 1, x = x + 1 }, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every (50 * millisecond) Tick




-- VIEW


view : Model -> Html Msg
view model =
  svg [ viewBox "0 0 100 100", width "300px" ]
    [ rect [ x "0", y "0", width "100", height "100", fill "#ceecee" ] []
    , rect [ x (toString model.x), y (toString model.y), width "1", height "1", fill "#000" ] []
    ]
