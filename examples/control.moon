
import Love, Color, MemberReference from require "framework.core"

import SceneNode, SceneTree, Tween, Easing, Vector from require "framework.scene_tree"

import NodeControl from require "framework.nodes"


lg = love.graphics


class NodeTest extends NodeControl

    new: (t = {}) =>

        super t

        @color = t.color

        @has_custom_pos_setter = true
        @has_custom_size_setter = true

        @custom_pos_setter = "_setPos"
        @custom_size_setter = "_setSize"

        @pos_twn = nil
        @size_twn = nil


    _draw: =>

        pos = @get "position"
        size = @get "size"


        Love\set "color", @color

        lg.rectangle "fill", pos.x, pos.y, size.x, size.y



    _setPos: (v) =>

        if @pos_twn != nil and @pos_twn\isStarted!

            @pos_twn\cancel!


        @pos_twn = Tween {
            ref: MemberReference @transform, "position"

            duration: 1
            easing: Easing.Circ.Out

            start_value: Vector\copy @transform.position
            end_value: v
        }


        @addTween(@pos_twn)\start!



    _setSize: (v) =>

        if @size_twn != nil and @size_twn\isStarted!

            @size_twn\cancel!


        @size_twn = Tween {
            ref: MemberReference @, "size", true

            duration: 1
            easing: Easing.Circ.Out

            start_value: Vector\copy @size
            end_value: v
        }


        @addTween(@size_twn)\start!





Love\connect "load", ->

    love.window.setMode 800, 640, {
        resizable: true
    }

    SceneTree\addChild NodeTest {
        color: Color\from(255, 0, 0),

        margin_left: 0.25
        margin_right: 0.75
        margin_top: 0.25
        margin_bottom: 0.75

        margin_left_type: NodeControl.MarginType.ratio
        margin_right_type: NodeControl.MarginType.ratio
        margin_top_type: NodeControl.MarginType.ratio
        margin_bottom_type: NodeControl.MarginType.ratio
    }
