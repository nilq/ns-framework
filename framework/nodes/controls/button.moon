
import Color, Love, MemberReference from require "framework.core"

import ComposedTween, Vector, Easing from require "framework.scene_tree"

import NodeBaseButton from require "framework.nodes.controls.base_button"


lg = love.graphics



--- @brief A button with a text.
---
--- Public member:
---   - background_color : The color of the background.
---   - background_alpha : The alpha of the background.
---   - border_width : The width of the border (<1 no border).
---   - border_color : The color of the border.
---   - border_radius : Corner radius of the border.
---   - text_color : The color of the text.
---   - halign : The horizontal alignement of the text.
---   - valign : The vertical alignement of the text.
---   - transition_time : Time between two state.
---   - hovered_* : Values of the button when hovered.
---   - clicked_* : Values of the button when clicked.
---
--- Properties:
---   - text [get, set] : The text of the button.
---   - font [get, set] : The font of the text.
---
class NodeButton extends NodeBaseButton


    --- @brief Alignement of the text.
    ---
    @Align: {
        left: 1
        top: 1

        center: 2

        right: 3
        bottom: 3
    }


    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t

        @type = "NodeButton"
        @theme_section = "button"


        @text = @_opt t.text, "Button"

        @background_color = @_topt t, "background_color", Color!
        @background_alpha = @_topt t, "background_alpha", 1

        @border_width = @_topt t, "border_width", 0
        @border_color = @_topt t, "border_color", Color!
        @border_radius = @_topt t, "border_radius", 0

        @text_color = @_topt t, "text_color", Color!
        @font = @_topt t, "font", lg.getFont!

        @halign = @_topt t, "halign", @@Align.left
        @valign = @_topt t, "valign", @@Align.top

        @transition_tween = nil

        @text_size = Vector!
        @text_size.x = @font\getWidth @text
        @text_size.y = @font\getHeight!


        @apply_transform_only_for_children = false


        @default_style = {
            transition_time: @_topt t, "transition_time", 0

            background_color: Color\copy @background_color
            background_alpha: @background_alpha

            border_width: @border_width
            border_color: Color\copy @border_color
            border_radius: @border_radius

            text_color: Color\copy @text_color
        }


        @hovered_style = {
            transition_time: @_topt t, "hovered_transition_time", 0

            background_color: @_topt t, "hovered_bg_color", Color!
            background_alpha: @_topt t, "hovered_bg_alpha", 1

            border_width: @_topt t, "hovered_border_width", 0
            border_color: @_topt t, "hovered_border_color", Color!
            border_radius: @_topt t, "hovered_border_radius", 0

            text_color: @_topt t, "hovered_text_color", Color!
        }


        @clicked_style = {
            transition_time: @_topt t, "clicked_transition_time", 0

            background_color: @_topt t, "clicked_bg_color", Color!
            background_alpha: @_topt t, "clicked_bg_alpha", 1

            border_width: @_topt t, "clicked_border_width", 0
            border_color: @_topt t, "clicked_border_color", Color!
            border_radius: @_topt t, "clicked_border_radius", 0

            text_color: @_topt t, "clicked_text_color", Color!
        }


        if t.minimize

            @_minimize = true


        @property "text", "getText", "setText"
        @property "font", "getFont", "setFont"


        @_connect "state-changed", "_onStateChanged"




    --- @brief Called when the node enters the scene tree.
    ---
    _enterTree: =>

        super!

        if @_minimize

            @minimize!




    --- @brief Called when the button's state is changed.
    ---
    _onStateChanged: =>

        style = nil

        if @state == NodeBaseButton.State.none

            style = @default_style

        elseif @state == NodeBaseButton.State.hovered

            style = @hovered_style

        else

            style = @clicked_style


        if @transition_tween != nil

            @transition_tween\cancel!


        @transition_tween = ComposedTween {

            duration: style.transition_time
            easing: Easing.Circ.Out

            animate: {

                object: @

                keys: {
                    "background_color"
                    "background_alpha"
                    "border_color"
                    "border_width"
                    "border_radius"
                    "text_color"
                }

                values: style

            }

        }

        @addTween @transition_tween
        @transition_tween\start!




    --- @brief Draws the control.
    ---
    _draw: =>

        Love\set "color", @background_color
        Love\set "alpha", @getSelfAlpha! * @background_alpha * 255

        lg.rectangle "fill", 0, 0, @size.x, @size.y, @border_radius


        Love\set "alpha", @getSelfAlpha! * 255

        if @border_width >= 1

            Love\set "color", @border_color
            lg.setLineWidth @border_width

        else

            lg.setLineWidth 1



        lg.rectangle "line", 0, 0, @size.x, @size.y, @border_radius


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




    --- @brief Minimize the control to the minimal size.
    ---
    minimize: =>

        @set "size", @text_size + Vector\from(14, 14)

{
    :NodeButton
}
