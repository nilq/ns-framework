
import Color, Love from require "framework.core"

import Vector from require "framework.scene_tree"

import NodeControl from require "framework.nodes.controls.control"



lg = love.graphics



--- @brief A GUI panel.
---
--- Public members:
---   - border_width : The width of the border (0 to disable).
---   - border_color : The color of the border.
---   - border_radius : The radius of the border in the corners.
---   - background_color : The color of the background.
---
--- Building table:
---   - border_width : The width of the border (0 to disable).
---   - border_color : The color of the border.
---   - border_radius : The radius of the border in the corners.
---   - background_color : The color of the background.
---
class NodePanel extends NodeControl


    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t


        @border_width = @_opt t.border_width, 0
        @border_color = @_opt t.border_color, Color!
        @border_radius = @_opt t.border_radius, 0

        @background_color = @_opt t.background_color, Color!

        @apply_transform_only_for_children = false




    --- @brief Draw the panel.
    ---
    _draw: =>

        Love\set "alpha", @getSelfAlpha! * 255


        Love\set "color", @background_color
        lg.rectangle "fill", 0, 0, @size.x, @size.y, @border_radius

        if @border_width != 0

            Love\set "color", @border_color
            lg.setLineWidth @border_width

        else

            lg.setLineWidth 2

        lg.rectangle "line", 0, 0, @size.x, @size.y, @border_radius




{
    :NodePanel
}
