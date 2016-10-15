
import SceneNode, Tween, Easing, Vector from require "framework.scene_tree"
import MemberReference from require "framework.core"


class TextNode extends SceneNode

    new: (t = {}) =>

        super t

        @text = @_opt t.text, "Default Text"

        @apply_transform_only_for_children = true
        @can_process = false

        @has_size = false



    _draw: =>

        love.graphics.print @text, @transform\toArgs!



node = nil


love.load = ->

    node = TextNode {
        text: "SceneNode example"

        position: Vector\from 100, 100
    }

    t = node\tween "position", Vector\from(100,100), Vector\from(200,200), Easing.Circ.InOut, 2

    t.repeat_count = -1
    t.repeat_delay = 0.5
    t.reflect = true

    t\start!


love.update = (dt) ->

    node\process dt


love.draw = ->

    node\draw!
