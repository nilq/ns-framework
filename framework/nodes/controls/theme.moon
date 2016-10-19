
import Object, Color from require "framework.core"


class Theme extends Object


    new: (t = {})=>

        if t.panel == nil

            t.panel = {}


        @panel = {

            background_color: @_opt t.panel.bg_color, Color\from 50,50,50

            border_color: @_opt t.panel.border_color, Color!
            border_width: @_opt t.panel.border_width, 0
            border_radius: @_opt t.panel.border_radius, 0

        }



{
    :Theme
}
