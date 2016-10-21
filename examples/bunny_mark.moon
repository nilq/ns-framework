
import NodeSprite                   from require "framework.nodes"
import Transform, Vector, SceneTree from require "framework.scene_tree"
import Love, Color                  from require "framework.core"

require "framework.tools.fps_counter"

{graphics: lg} = love

GRAVITY = 20
SPEED   = 10

bunnies    = 0
mouse_down = false

class BunnyNode extends NodeSprite

    new: (t = {}) =>
        super t

        @velocity = Vector {
            x: 0
            y: 0
        }

    _process: (dt) =>

        @velocity.y += GRAVITY * dt
        @velocity.x += SPEED   * dt

        if @transform.position.y + @size.y >= lg.getHeight!
            @velocity.y = -GRAVITY

        if @transform.position.x >= lg.getWidth!
            @velocity.x *= -1
        elseif @transform.position.x <= 0
            @velocity.x *= -1

        @transform.position += @velocity

    _draw: =>
        super!

Love\connect "load", ->
    export bunny_img = lg.newImage "examples/assets/wabbit.png"
    bunny_img\setFilter "nearest", "nearest"

Love\connect "process", (dt) ->
    if mouse_down
        SceneTree\addChild BunnyNode {
            image: bunny_img
            transform: Transform {
                position: Vector {
                    x: 20
                    y: 20
                }
            }
            color: Color!
        }

        bunnies += 1

Love\connect "draw", ->
    lg.print "bunnies: " .. bunnies, 0, 32

Love\connect "mouse-pressed", (x, y, button) ->
    mouse_down = button == 1

Love\connect "mouse-released", (x, y, button) ->
    mouse_down = not button == 1
