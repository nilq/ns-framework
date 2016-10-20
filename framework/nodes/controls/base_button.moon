
import Color, Love from require "framework.core"

import Vector, Rectangle from require "framework.scene_tree"

import NodeControl from require "framework.nodes.controls.control"



--- @brief Basic class for every button element.
---
--- Public member:
---   - state : The state of the button. Should not be modified.
---
--- Signals:
---   - clicked() : Called when the button is clicked.
---
class NodeBaseButton extends NodeControl


    --- @brief The state of the button.
    ---
    @State: {
        none: 0
        hovered: 1
        clicked: 2
    }



    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t

        @state = @@State.none

        @stop_mouse = true


        @addSignal "clicked"

        @addEventHandler "mouse-pressed", "_onMousePressed"
        @addEventHandler "mouse-released", "_onMouseReleased"


        @_connect "mouse-enter", "_onMouseEnter"
        @_connect "mouse-exit", "_onMouseExit"




    --- @brief Called when the mouse enters the control.
    ---
    _onMouseEnter: =>

        if @state == @@State.none

            @state = @@State.hovered


    --- @brief Called when the mouse exits the control.
    ---
    _onMouseExit: =>

        if @state == @@State.hovered

            @state = @@State.none




    --- @brief Called when a mouse button is pressed.
    ---
    --- @param ev : The event.
    ---
    _onMousePressed: (ev) =>

        super ev


        if ev.args[3] != 1

            return


        m_pos = Vector\from ev.args[1], ev.args[2]

        fvec = @getFinalInvertedTransform!\transformVector m_pos
        rect = Rectangle!

        rect.b = @get "size"

        if rect\contains(fvec)

            @state = @@State.clicked
            @emit "clicked"

            if @stop_mouse

                ev.stop_propagation = true


    --- @brief Called when a mouse button is released.
    ---
    --- @param ev : The event.
    ---
    _onMouseReleased: (ev) =>


        if ev.args[3] != 1

            return


        if @state == @@State.clicked

            m_pos = Vector\from ev.args[1], ev.args[2]

            fvec = @getFinalInvertedTransform!\transformVector m_pos
            rect = Rectangle!

            rect.b = @get "size"

            if rect\contains(fvec)

                @state = @@State.hovered

            else

                @state = @@State.none




{
    :NodeBaseButton
}
