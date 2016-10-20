
import Love from require "framework.core"

import Vector from require "framework.scene_tree.transform"
import SceneNode from require "framework.scene_tree.scene_node"
import Event from require "framework.scene_tree.event"


lg = love.graphics



--- @brief The root of the scene tree.
---
--- Properties:
---   - size [get] : Get the size of the window.
---
--- Signals:
---   - resized() : Called when the window is resized.
---
class _SceneTree extends SceneNode


    --- @brief Create a new instance.
    ---
    new: =>

        super {

            is_spatial: false

            properties: {
                {"size", "getSize", "setSize"}
            }

            signals: {
                "resized"
            }
        }

        @in_tree = true
        @ready = true




    --- @brief Get the size of the scene tree (the window).
    ---
    getSize: =>

        return Vector\from lg.getDimensions!


    --- @brief Set the size of the scene tree (the window).
    ---
    --- @note This setter is forbidden, so it will raise an error.
    ---
    setSize: (v) =>

        error "Can't set the size of the scene tree"




SceneTree = _SceneTree!



Love\connect "process", (dt) ->

    SceneTree\process dt


Love\connect "draw", ->

    SceneTree\draw!


Love\connect "resize", ->

    SceneTree\emit "resized"



-- TODO: Handles "framework.scene_tree.events_for_love"

Love\connect "mouse-moved", (x, y, dx, dy, istouch) ->

    ev = Event "mouse-moved", x, y, dx, dy, istouch

    SceneTree\event ev


Love\connect "mouse-pressed", (x, y, button, istouch) ->

    ev = Event "mouse-pressed", x, y, button, istouch

    SceneTree\event ev


Love\connect "mouse-released", (x, y, button, istouch) ->

    ev = Event "mouse-released", x, y, button, istouch

    SceneTree\event ev



{
    :SceneTree
}
