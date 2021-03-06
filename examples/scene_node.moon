
import MemberReference, Love from require "framework.core"

import SceneNode, Tween, Easing, Vector from require "framework.scene_tree"


require "framework.tools.fps_counter"



class TextNode extends SceneNode

    new: (t = {}) =>

        super t

        @text = @_opt t.text, "Default Text"

        @can_process = false

        @has_size = false



    _draw: =>

        love.graphics.print @text, @transform\toArgs!



node = nil


Love\connect "load", (args) ->

    node = TextNode {
        text: "SceneNode example"

        position: Vector\fromData {x: 100}
    }


    t = node\tween "position", Vector\from(100,100), Vector\from(200,200), Easing.Circ.InOut, 2

    t.repeat_count = -1
    t.repeat_delay = 0.5
    t.reflect = true

    t\start!



Love\connect "process", (dt) ->

    node\process dt


Love\connect "draw",  ->

    node\draw!
