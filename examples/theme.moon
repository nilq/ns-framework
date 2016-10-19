
import Love, Color, MemberReference from require "framework.core"

import SceneNode, SceneTree, Tween, Easing, Vector from require "framework.scene_tree"

import Theme, NodePanel, NodeControl from require "framework.nodes"


lg = love.graphics



Love\connect "load", ->

    theme = Theme!

    SceneTree\addChild NodePanel {
        theme: theme

        margin_left: 0.25
        margin_right: 0.75
        margin_top: 0.25
        margin_bottom: 0.75

        margin_left_type: NodeControl.MarginType.ratio
        margin_right_type: NodeControl.MarginType.ratio
        margin_top_type: NodeControl.MarginType.ratio
        margin_bottom_type: NodeControl.MarginType.ratio
    }
