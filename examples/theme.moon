
import Love, Color, MemberReference from require "framework.core"

import SceneNode, SceneTree, Tween, Easing, Vector from require "framework.scene_tree"

import
    Theme
    NodeCheckbox
    NodeButton
    from require "framework.nodes"


lg = love.graphics



Love\connect "load", ->

    theme = Theme!


    SceneTree\addChild NodeCheckbox {
        theme: theme

        text: "Checkbox"

        pos: Vector\from 100, 100
        minimize: true
    }


    SceneTree\addChild NodeButton {
        theme: theme

        text: "Button"

        pos: Vector\from 100, 200
        minimize: true
    }
