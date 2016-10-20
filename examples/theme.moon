
import Love, Color, MemberReference from require "framework.core"

import SceneNode, SceneTree, Tween, Easing, Vector from require "framework.scene_tree"

import Theme, NodeButton, NodeControl from require "framework.nodes"


lg = love.graphics



Love\connect "load", ->

    theme = Theme!

    SceneTree\addChild NodeButton {
        theme: theme

        text: "Button"

        pos: Vector\from 100, 100

        minimize: true
    }
