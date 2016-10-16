
import Color from require "framework.core"

import SceneNode, Vector, Transform from require "framework.scene_tree"


lg = love.graphics


class NodeSprite extends SceneNode


    new: (t = {}) =>

        super t

        @type = "NodeSprite"

        @image = t.image
        @quad = t.quad

        @color = @_opt t.color, Color!


        if @image == nil

            error "A sprite needs a image !"


        @size = Vector\from @image\getDimensions!


        @property "sprite-size", "getSpriteSize", "setSpriteSize"



    _draw: =>

        trans = Transform\copy @transform

        size_scaling = @size / @get("sprite-size")
        trans.scale *= size_scaling

        if quad == nil

            lg.draw @image, trans\toArgs!

        else

            lg.draw @image, @quad, trans\toArgs!



    getSpriteSize: =>

        if @quad == nil

            return Vector\from @image\getDimensions!

        else

            x, y, w, h = @quad\getViewport!

            return Vector\from w, h
