
import Love, Color, MemberReference from require "framework.core"

import SceneNode, SceneTree, Tween, Easing, Vector from require "framework.scene_tree"

import Theme, NodeLabel, NodeControl from require "framework.nodes"


lg = love.graphics



Love\connect "load", ->

    theme = Theme!

    SceneTree\addChild NodeLabel {
        theme: theme

        text: "Lol"
        has_background: true

        pos: Vector\from 100, 100
        size: Vector\from 101, 101
    }
