
import Object, Love from require "framework.core"

import Vector, Rectangle from require "framework.scene_tree"



tbl = table



control_sorter = (a, b) ->

    return a.control_depth > b.control_depth



--- @brief The controller for the controls.
---
class _GuiController extends Object


    --- @brief Create a new instance.
    ---
    new: (t = {}) =>

        super t

        @controls = {}

        @focused = nil

        @_in_event = false
        @_to_remove = {}




    --- @brief Request the focus.
    ---
    --- @param control : The control requesting the control.
    --- @return If the control gained the focus.
    ---
    requestFocus: (control) =>

        if @focused == control

            return true


        if @focused != nil

            if @focused\keepFocus!

                return false

            @focused.focused = false
            @focused\emit "focus-lost"


        @focused = control
        @focused.focused = true
        @focused\emit "focus-gain"

        return true


    --- @brief Release the focus.
    ---
    --- @param control : The control currently owning the focus.
    ---
    releaseFocus: (control) =>

        if @focused == control

            @focused\emit "focus-lost"
            @focused = nil




GuiController = _GuiController!



{
    :GuiController
}
