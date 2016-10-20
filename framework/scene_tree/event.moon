

--- @brief An event used with the nodes.
---
--- Public members :
---   - name : The event's name.
---   - args : The event's arguments.
---   - stop_propagation : Stop the event's propagation.
---
class Event


    --- @brief Create a new instance.
    ---
    --- @param name : The event's name.
    --- @param ... : The event's arguments.
    ---
    new: (name, ...) =>

        @name = name

        @args = {...}

        @stop_propagation = false



{
    :Event
}
