
import Color, Love from require "framework.core"

import Vector from require "framework.scene_tree"

import NodeControl from require "framework.nodes.controls.control"



lg = love.graphics


--- @brief A GUI label.
---
--- Public members :
---   - has_background : The label has a background ?
---   - background_color : The color of the background.
---   - background_radius : The radius of the background.
---   - background_alpha : The alpha of the background.
---   - text_color : The color of the text.
---   - halign : The horizontal alignement of the text.
---   - valign : The vertial alignement of the text.
---
--- Properties :
---   - text [get, set] : The text of the label.
---   - font [get, set] : The font of the text.
---
class NodeLabel extends NodeControl


    --- @brief Alignement of the text.
    ---
    @Align: {
        left: 1
        top: 1

        center: 2

        right: 3
        bottom: 4
    }


    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t

        @type = "NodeLabel"
        @theme_section = "label"

        @text = @_opt t.text, ""

        @has_background = @_topt t, "has_background", false
        @background_color = @_topt t, "background_color", Color!
        @background_radius = @_topt t, "background_radius", 0
        @background_alpha = @_topt t, "background_alpha", 1

        @text_color = @_topt t, "text_color", Color!
        @font = @_topt t, "font", lg.getFont!

        @halign = @_topt t, "halign", @@Align.left
        @valign = @_topt t, "valign", @@Align.top

        @text_size = Vector!
        @text_size.x = @font\getWidth @text
        @text_size.y = @font\getHeight!

        @apply_transform_only_for_children = false


        @property "text", "getText", "setText"
        @property "font", "getFont", "setFont"




    --- @brief Draws the label.
    ---
    _draw: =>

        Love\set "alpha", @getSelfAlpha! * 255


        if @has_background

            Love\set "color", @background_color
            lg.rectangle "fill", 0, 0, @size.x, @size.y, @background_radius


        x = 0
        y = 0


        if @halign == @@Align.center

            x = (@size / 2 - @text_size / 2).x

        elseif @halign == @@Align.right

            x = (@size - @text_size).x


        if @valign == @@Align.center

            y = (@size / 2 - @text_size / 2).y

        elseif @valign == @@Align.bottom

            y = (@size - @text_size).y


        Love\set "color", @text_color
        lg.setFont @font
        lg.print @text, x, y




    --- @brief Get the text.
    ---
    getText: =>

        return @text


    --- @brief Set the text.
    ---
    setText: (v) =>

        @text = v
        @text_size.x = @font\getWidth @text
        @text_size.y = @font\getHeight!




    --- @brief Get the font.
    ---
    getFont: =>

        return @font


    --- @brief Set the font.
    ---
    setFont: (v) =>

        @font = v
        @text_size.x = @font\getWidth @text
        @text_size.y = @font\getHeight!




{
    :NodeLabel
}
