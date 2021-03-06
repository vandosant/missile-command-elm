import Html exposing (Html)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, millisecond)
import VirtualDom exposing (Node)
import Random exposing (float, generate)


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
  , missiles : List IndexedMissile
  }


makeIndexedMissile : Float -> IndexedMissile
makeIndexedMissile velocity =
  { x = 0
  , y = 0
  , velocity = velocity
  }


model : Model
model =
  { score = 0
  , missiles =
    List.map makeIndexedMissile [0.1, 0.2, 0.3, 0.4]
  }


init : (Model, Cmd Msg)
init =
  (model, Cmd.none)


-- UPDATE


type Msg =
  Tick Time |
  NewMissile Float


update : Msg -> Model -> (Model, Cmd Msg)
update msg ({score, missiles} as model) =
  case msg of
    Tick newTime ->
      let
        filteredMissiles =
          List.filter isOnCanvas
            (List.map updateMissile missiles)
        nextMissile =
          if List.length filteredMissiles < 4 then
            Random.generate NewMissile (Random.float 0.1 0.3)
          else
            Cmd.none
      in
        ({ model |
          missiles = filteredMissiles
         }, nextMissile)
    NewMissile velocity ->
      ({ model |
        missiles =
          (makeIndexedMissile velocity) :: missiles
       }, Cmd.none)

isOnCanvas : IndexedMissile -> Bool
isOnCanvas missile =
  missile.x < 100 || missile.y < 100

updateMissile : IndexedMissile -> IndexedMissile
updateMissile missile = {x = missile.x + missile.velocity
        , y = missile.y + missile.velocity
        , velocity = missile.velocity }

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every millisecond Tick




-- VIEW


view : Model -> Html Msg
view model =
  let
    canvas =
       rect [ x "0", y "0", width "100", height "100", fill "#ceecee" ] []
    missiles =
      List.map viewIndexedMissile model.missiles
  in
    svg [ viewBox "0 0 100 100", width "300px" ] ([canvas] ++ missiles)

viewIndexedMissile : IndexedMissile -> VirtualDom.Node a
viewIndexedMissile missile =
  rect [ x (toString missile.x), y (toString missile.y), width "1", height "1", fill "#000" ] []
