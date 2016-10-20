
import Color, Love, MemberReference from require "framework.core"

import ComposedTween, Vector, Easing from require "framework.scene_tree"

import NodeBaseButton from require "framework.nodes.controls.base_button"


lg = love.graphics



--- @brief A checkbox with an optional label.
---
--- Public members:
---   - checked : If the checkbox is checked.
---   - text_color : The color of the text.
---   - has_background : The checkbox has a background ?
---   - background_color : The color of the background.
---   - background_alpha : The alpha of the background.
---   - box_size : The size of the check box.
---   - box_color : The color of the check box.
---   - box_radius : The radius of the corner of the check box.
---   - box_border_width : The width of the check box's border.
---   - box_border_color : The color of the check box's border.
---   - hovered_* : Values of the checkbox when hovered.
---   - checked_* : Values of the checkbox when checked.
---
--- Properties:
---   - text [get, set] : The text of the checkbox.
---   - font [get, set] : The font of the text.
---
class NodeCheckbox extends NodeBaseButton


    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t

        @type = "NodeCheckbox"
        @theme_section = "checkbox"


        @checked = @_opt t.checked, false

        @text = @_opt t.text, ""
        @text_color = @_topt t, "text_color", Color!
        @font = @_topt t, "font", lg.getFont!

        @has_background = @_topt t, "has_background", true
        @background_color = @_topt t, "background_color", Color!
        @background_alpha = @_topt t, "background_alpha", 1

        @box_size = @_topt t, "box_size", Vector\from 16,16
        @box_color = @_topt t, "box_color", Color!
        @box_radius = @_topt t, "box_radius", 0
        @box_border_width = @_topt t, "box_border_width", 0
        @box_border_color = @_topt t, "box_border_color", Color!

        @transition_tween = nil

        @text_size = Vector!
        @text_size.x = @font\getWidth @text
        @text_size.y = @font\getHeight!


        @apply_transform_only_for_children = false


        @default_style = {

            transition_time: @_topt t, "transition_time", 0

            background_color: Color\copy @background_color
            background_alpha: @background_alpha

            box_size: Vector\copy @box_size
            box_color: Color\copy @box_color
            box_radius: @box_radius
            box_border_width: @box_border_width
            box_border_color: Color\copy @box_border_color

        }


        @hovered_style = {

            transition_time: @_topt t, "hovered_transition_time", 0

            background_color: @_topt t, "hovered_bg_color", Color!
            background_alpha: @_topt t, "hovered_bg_alpha", 1

            box_size: @_topt t, "hovered_box_size", Vector\from 16,16
            box_color: @_topt t, "hovered_box_color", Color!
            box_radius: @_topt t, "hovered_box_radius", 0
            box_border_width: @_topt t, "hovered_box_border_width", 0
            box_border_color: @_topt t, "hovered_box_border_color", Color!

        }


        @checked_style = {

            transition_time: @_topt t, "checked_transition_time", 0

            background_color: @_topt t, "checked_bg_color", Color!
            background_alpha: @_topt t, "checked_bg_alpha", 1

            box_size: @_topt t, "checked_box_size", Vector\from 16,16
            box_color: @_topt t, "checked_box_color", Color!
            box_radius: @_topt t, "checked_box_radius", 0
            box_border_width: @_topt t, "checked_box_border_width", 0
            box_border_color: @_topt t, "checked_box_border_color", Color!

        }


        if t.minimize

            @_minimize = true


        @property "text", "getText", "setText"
        @property "font", "getFont", "setFont"


        @_connect "state-changed", "_onStateChanged"
        @_connect "clicked", "_onClicked"




    --- @brief Called when the node enters the tree.
    ---
    _enterTree: =>

        super!

        if @_minimize

            @minimize!




    --- @brief Called when the state change.
    ---
    _onStateChanged: =>

        style = nil
        keys = {}

        if @checked

            style = @checked_style

        else

            if @state == NodeBaseButton.State.none

                style = @default_style

            else

                style = @hovered_style


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
                    "box_size"
                    "box_color"
                    "box_radius"
                    "box_border_width"
                    "box_border_color"
                }

                values: style

            }

        }

        @addTween @transition_tween
        @transition_tween\start!




    --- @brief Called when the button is checked.
    ---
    _onClicked: =>

        @checked = not @checked




    --- @brief Draw the node.
    ---
    _draw: =>

        if @has_background

            Love\set "color", @background_color
            Love\set "alpha", @getSelfAlpha! * @background_alpha * 255

            lg.rectangle "fill", 0, 0, @size.x, @size.y


        x, y = 0, 0


        x = 4
        y = @size.y / 2 - @box_size.y / 2

        Love\set "color", @box_color
        Love\set "alpha", @getSelfAlpha! * 255

        lg.rectangle "fill", x, y, @box_size.x, @box_size.y, @box_radius


        if @box_border_width >= 1

            Love\set "color", @box_border_color

            lg.setLineWidth @box_border_width

        else

            lg.setLineWidth 1

        lg.rectangle "line", x, y, @box_size.x, @box_size.y, @box_radius


        x = 4 + @box_size.x + 4
        y = @size.y / 2 - @text_size.y / 2

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

        s = Vector!

        if @box_size.y > @text_size.y

            s.y = @box_size.y

        else

            s.y = @text_size.y

        s.x = @box_size.x + 4 + @text_size.x

        @set "size", s + Vector\from(14, 14)



{
    :NodeCheckbox
}
