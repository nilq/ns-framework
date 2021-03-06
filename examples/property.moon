
import Object from require "framework.core"



class Example extends Object

    new: =>

        super {
            properties: {
                {"first", "getFirst", "setFirst"}
            }
        }

        @property "second", "getSecond", "setSecond"

        @_first = 0
        @_second = 0



    getFirst: =>

        return @_first

    setFirst: (v) =>

        @_first = v
        return v


    getSecond: =>

        return @_second + 2

    setSecond: (v) =>

        @_second = v
        return v + 2



example = Example!

print "first = ", example\get "first" -- 0
print "second = ", example\get "second" -- 2

example\set "first", 5
example\set "second", 5

print "first 2 = ", example\get "first" -- 5
print "second 2 = ", example\get "second" -- 7
