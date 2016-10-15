
import MemberReference from require "framework.core"

import Tween, Easing, Vector from require "framework.scene_tree"


obj = {
    pos: Vector\from 100, 100
}
tween = nil


love.load = ->

    tween = Tween {
        ref: MemberReference obj, "pos"

        start_value: Vector\from 100, 100
        end_value: Vector\from 200, 200

        start_delay: 1
        duration: 2

        repeat_delay: 0.5
        repeat_count: -1
        reflect: true

        easing: Easing.Circ.Out
    }

    tween\connect "started", ->
        print "Tween started !"

    tween\start!



love.update = (dt) ->

    tween\process dt


love.draw = ->

    love.graphics.print "Tween example", obj.pos.x, obj.pos.y
