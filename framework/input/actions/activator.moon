
import Object from require "framework.core"

--- @brief Generic activator class for keybindings.
---
class Activator extends Object

    --- @brief Create new instance of activator.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t

        @type = "Activator"


    --- @brief Create new instance from data table.
    ---
    --- @param data : Table of information.
    ---
    @fromData: (data) =>


    --- @brief Get serialized activator as table.
    ---
    --- @return The serialiation as table.
    ---
    getData: =>
