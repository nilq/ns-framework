


--- @brief Basic class for every framework's objects.
---
--- Contains a property systems.
---
--- Public member(s) :
---  - type [readonly] : Get the class' name.
---  - name : Get/set the instance's name.
---
class Object


    getters: {}
    setters: {}


    __inherited: (cls) =>

        old_init = cls.__init

        cls.__init = (...) =>
            old_init @, ...

            mt = getmetatable @
            old_index = mt.__index

            mt.__index = (name) =>


                if type(old_index) == "function"
                    old_index @, name

                else

                    if getters = old_index.getters
                        if getters[name]
                            return getters[name] @

                    old_index[name]







            mt.__newindex = (name, value) =>

                if setters = old_index.setters
                    if setters[name]
                        return setters[name] @, value

                elseif type(old_index) == "table"
                    old_index[name] = value




    __newindex: (name, value) =>

        if not @setters

            rawset @, name, value
            return

        if setter = @setters[name]

            setter @, value

        else

            rawset @, name, value





    --- @brief Contructor
    ---
    --- Create a new instance from a building table.
    ---
    --- @param t : Building table.
    ---
    new: (t = {}) =>

        @type = "Object"
        @name = nil


        if t.properties


            for prop in *t.properties

                @property prop[1], prop[2], prop[3]




    --- @brief Optional parameter in building tables.
    ---
    --- @param v : The value of the parameter.
    --- @param def : The default value.
    ---
    --- @return The value of the parameter if not nil, or the default one.
    ---
    _opt: (v, def) =>

        unless v != nil

            return def

        return v




    --- @brief Create a new property.
    ---
    --- @param name : The property's name.
    --- @param getter : The getter method's name.
    --- @param setter : The setter method's name.
    ---
    property: (name, getter, setter) =>

        @getters[name] = @[getter]
        @setters[name] = @[setter]




    --- @brief Get a field in the object.
    ---
    --- @param name : The field name.
    --- @return The value of the field.
    ---
    get: (name) =>

        if @getters[name]

            return @getters[name] @


        return @[name]


    --- @brief Set a field in the object.
    ---
    --- @param name : The field's name.
    --- @param value : The new field's value.
    ---
    --- @return The new value of the field.
    ---
    set: (name, value) =>

        if @setters[name]

            return @setters[name] @, value


        @[name] = value
        return value



{
    :Object
}
