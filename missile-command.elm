import Html exposing (Html)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)




main =
  App.beginnerProgram
    { model = model
    , view = view
    , update = update
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




-- UPDATE


type Msg = IncrementScore
  | ResetScore


update : Msg -> Model -> Model
update msg ({score, x, y} as model) =
  case msg of
    IncrementScore ->
      { model | score = score + 1 }

    ResetScore ->
      { model | score = 0 }


-- VIEW


view : Model -> Html Msg
view model =
  svg [ viewBox "0 0 100 100", width "300px" ]
    [ rect [ x "10", y "10", width "100", height "100", fill "#ceecee" ] [] ]
