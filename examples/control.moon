
import Love, Color, MemberReference from require "framework.core"

import SceneNode, SceneTree, Tween, Easing, Vector from require "framework.scene_tree"

import NodeControl, GuiController from require "framework.nodes"


lg = love.graphics


class NodeTest extends NodeControl

    new: (t = {}) =>

        super t

        @color = t.color

        @_connect "mouse-enter", "onMouseEnter"
        @_connect "mouse-exit", "onMouseExit"
        @_connect "focus-gain", "onFocusGain"
        @_connect "focus-lost", "onFocusLost"


        @apply_transform_only_for_children = false
        @stop_mouse = true

        @dbg = t.dbg

        if t.dbg

            @transform.floor = true



    _draw: =>

        pos = @get "position"
        size = @get "size"


        Love\set "color", @color

        lg.rectangle "fill", 0, 0, size.x, size.y

        if @dbg

            lg.setColor 255, 255, 255, 255
            lg.print "Margin modified ? #{@_margin_modified}", 0, 0



    onMouseEnter: =>

        if not @focused

            @color = Color\from 255,0,255


    onMouseExit: =>

        if not @focused

            @color = Color\from 255,0,0

    onFocusGain: =>

        @color = Color\from 0,255,0

    onFocusLost: =>

        if @hovered

            @color = Color\from 255,0,255

        else

            @color = Color\from 255,0,0



Love\connect "load", ->

    love.window.setMode 800, 640, {
        resizable: true
    }

    nt = SceneTree\addChild NodeTest {
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


    nt\addChild NodeTest {
        color: Color\from(255, 0, 0),

        margin_left: 0.4
        margin_right: 0.6
        margin_top: 0.4
        margin_bottom: 0.6

        margin_left_type: NodeControl.MarginType.ratio
        margin_right_type: NodeControl.MarginType.ratio
        margin_top_type: NodeControl.MarginType.ratio
        margin_bottom_type: NodeControl.MarginType.ratio

        dbg: true
    }
