
import Object, Color from require "framework.core"


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



{
    :Theme
}
