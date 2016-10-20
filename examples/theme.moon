
import Love, Color, MemberReference from require "framework.core"

import SceneNode, SceneTree, Tween, Easing, Vector from require "framework.scene_tree"

import Theme, NodeBaseButton, NodeControl from require "framework.nodes"


lg = love.graphics



Love\connect "load", ->

    theme = Theme!

    SceneTree\addChild NodeBaseButton {
        theme: theme

        pos: Vector\from 100, 100
        size: Vector\from 101, 101
    }
