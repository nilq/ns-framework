
import Object, Color from require "framework.core"

import Vector from require "framework.scene_tree"




--- @brief A GUI theme.
---
class Theme extends Object


    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {})=>

        if t.panel == nil
            t.panel = {}

        if t.label == nil
            t.label = {}

        if t.button == nil
            t.button = {}

        if t.checkbox == nil
            t.checkbox = {}


        @panel = {

            background_color: @_opt t.panel.background_color, Color\from 50,50,50
            background_alpha: @_opt t.panel.background_alpha, 1

            border_color: @_opt t.panel.border_color, Color!
            border_width: @_opt t.panel.border_width, 0
            border_radius: @_opt t.panel.border_radius, 0

        }

        @label = {

            has_background: @_opt t.label.has_background, false
            background_color: @_opt t.label.background_color, Color\from 50,50,50
            background_radius: @_opt t.label.background_radius, 0
            background_alpha: @_opt t.label.background_alpha, 1

            text_color: @_opt t.label.text_color, Color!
            font: @_opt t.label.font, love.graphics.getFont!

            halign: @_opt t.label.halign, 2 -- center
            valign: @_opt t.label.valign, 2 -- center

        }

        @button = {

            transition_time: 1

            background_color: @_opt t.button.background_color, Color\from 55,50,55
            background_alpha: @_opt t.button.background_alpha, 1

            border_width: @_opt t.button.border_width, 0
            border_color: @_opt t.button.border_color, Color\from 110,110,110
            border_radius: @_opt t.button.border_radius, 0

            text_color: @_opt t.button.text_color, Color!
            font: @_opt t.button.font, love.graphics.getFont!

            halign: @_opt t.button.halign, 2 -- center
            valign: @_opt t.button.valign, 2 -- center


            hovered_transition_time: 1

            hovered_bg_color: @_opt t.button.hovered_bg_color, Color\from 25,25,25
            hovered_bg_alpha: @_opt t.button.hovered_bg_alpha, 1

            hovered_border_width: @_opt t.button.hovered_border_width, 0
            hovered_border_color: @_opt t.button.hovered_border_color, Color\from 50,50,50
            hovered_border_radius: @_opt t.button.hovered_border_radius, 10

            hovered_text_color: @_opt t.button.hovered_text_color, Color!


            clicked_transition_time: 0.2

            clicked_bg_color: @_opt t.button.clicked_bg_color, Color\from 70,70,70
            clicked_bg_alpha: @_opt t.button.clicked_bg_alpha, 1

            clicked_border_width: @_opt t.button.clicked_border_width, 0
            clicked_border_color: @_opt t.button.clicked_border_color, Color\from 25,25,25
            clicked_border_radius: @_opt t.button.clicked_border_radius, 14

            clicked_text_color: @_opt t.button.clicked_text_color, Color\from 255,150,150

        }

        @checkbox = {

            has_background: @_opt t.checkbox.has_background, false

            transition_time: 1

            background_color: @_opt t.checkbox.background_color, Color\from 55,50,55
            background_alpha: @_opt t.checkbox.background_alpha, 1

            box_size: @_opt t.checkbox.box_size, Vector\from 16,16
            box_color: @_opt t.checkbox.box_color, Color\from 200,200,200
            box_radius: @_opt t.checkbox.box_radius, 4
            box_border_width: @_opt t.checkbox.box_border_width, 0
            box_border_color: @_opt t.checkbox.box_border_color, Color\from 110,110,110


            hovered_transition_time: 1

            hovered_bg_color: @_opt t.checkbox.hovered_bg_color, Color\from 25,25,25
            hovered_bg_alpha: @_opt t.checkbox.hovered_bg_alpha, 1

            hovered_box_size: @_opt t.checkbox.hovered_box_size, Vector\from 16,16
            hovered_box_color: @_opt t.checkbox.hovered_box_color, Color\from 255,200,200
            hovered_box_radius: @_opt t.checkbox.hovered_box_radius, 4
            hovered_box_border_width: @_opt t.checkbox.hovered_box_border_width, 0
            hovered_box_border_color: @_opt t.checkbox.hovered_box_border_color, Color\from 110,110,110


            checked_transition_time: 0.5

            checked_bg_color: @_opt t.checkbox.checked_bg_color, Color\from 25,25,25
            checked_bg_alpha: @_opt t.checkbox.checked_bg_alpha, 1

            checked_box_size: @_opt t.checkbox.checked_box_size, Vector\from 16,16
            checked_box_color: @_opt t.checkbox.checked_box_color, Color\from 80,40,50
            checked_box_radius: @_opt t.checkbox.checked_box_radius, 6
            checked_box_border_width: @_opt t.checkbox.checked_box_border_width, 2
            checked_box_border_color: @_opt t.checkbox.checked_box_border_color, Color\from 100,50,60

        }


{
    :Theme
}
