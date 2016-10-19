
import Object from require "framework.core"


import sqrt, min, max, sin, cos, floor from math
lg = love.graphics


--- @brief A 2D vector.
---
--- Supports the following meta-methods:
---   - Vector + Vector
---   - Vector - Vector
---   - Vector * Vector
---   - Vector / Vector
---   - Vector == Vector
---   - -Vector
---   - Vector * number
---   - Vector / number
---
--- Building table parameters :
---   - x : The X position of the vector (optional).
---   - y : The Y position of the vector (optional).
---
class Vector extends Object



    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t

        @type = "Vector"

        @x = @_opt t.x, 0
        @y = @_opt t.y, 0




    --- @brief Create a new instance from two scalars.
    ---
    --- Syntaxes:
    ---   - Vector\from number
    ---   - Vector\from number, number
    ---
    --- @param x : The X position.
    --- @param y : The Y position (optional).
    ---
    --- @return The created vector.
    ---
    @from: (x, y=x) =>

        return Vector {:x, :y}


    ---@brief Create a new instance from a table of data(x, y)
    ---
    --- Syntaxes:
    ---   - Vector\fromData {x: number, y: number}
    ---   - Vector\fromData {x: number}
    ---
    --- @param data : Table of positions(x, y)
    ---
    --- @return The created vector.
    ---
    @fromData: (data) =>

        return Vector {x: data.x, y: data.y or data.x}


    --- @brief Create a copy of the given instance.
    ---
    --- @param vec : Vector to copy.
    ---
    --- @return The created vector.
    ---
    @copy: (vec) =>

        return Vector {x: vec.x, y: vec.y}




    --- @brief Get the top vector.
    ---
    --- @return The top vector (0; 1).
    ---
    @top: =>

        return Vector {x: 0, y: 1}


    --- @brief Get the bottom vector.
    ---
    --- @return The bottom vector (0; -1).
    ---
    @bottom: =>

        return Vector {x: 0, y: -1}


    --- @brief Get the right vector.
    ---
    --- @return The right vector (1; 0).
    ---
    @right: =>

        return Vector {x: 1, y: 0}


    --- @brief Get the left vector.
    ---
    --- @return The left vector (-1; 0).
    ---
    @left: =>

        return Vector {x: -1, y: 0}




    --- @brief Get the squared length of the vector.
    ---
    --- @return The squared length of the vector.
    ---
    lengthSquared: =>

        return @x*@x + @y*@y


    --- @brief Get the length of the vector.
    ---
    --- @return The length of the vector.
    ---
    length: =>

        return sqrt @x*@x + @y*@y




    --- @brief Get the serialization of the vector.
    ---
    --- @return The serialized vector as a table {x: number, y: number}.
    ---
    getData: =>
      return {x: @x, y: @y}




    --- @brief Get the inverted vector of the current instance.
    ---
    --- 1 / Vector
    ---
    --- @return The inverted vector.
    ---
    inverted: =>

        x = 0
        y = 0

        if @x != 0

            x = 1 / @x

        if @y != 0

            y = 1 / @y


        return Vector {:x, :y}


    --- @brief Invert the current instance.
    ---
    --- 1 / Vector
    ---
    --- @return The current instance.
    ---
    invert: =>

        if @x != 0

            @x = 1 / @x

        if @y != 0

            @y = 1 / @y


        return @




    --- @brief Operator overload : a + b
    ---
    __add: (other) =>

        return Vector {
            x: @x + other.x
            y: @y + other.y
        }


    --- @brief Operator overload : a - b
    ---
    __sub: (other) =>

        return Vector {
            x: @x - other.x
            y: @y - other.y
        }


    --- @brief Operator overload : a * b
    ---
    __mul: (other) =>

        if type(other) == "number"

            return Vector {
                x: @x * other
                y: @y * other
            }

        else

            return Vector {
                x: @x * other.x
                y: @y * other.y
            }


    --- @brief Operator overload : a / b
    ---
    __div: (other) =>

        if type(other) == "number"

            return Vector {
                x: @x / other
                y: @y / other
            }

        else

            return Vector {
                x: @x / other.x
                y: @y / other.y
            }


    --- @brief Operator overload : -a
    ---
    __unm: =>

        return Vector {x: -@x, y: -@y}


    --- @brief Operator overload : a == b
    ---
    __eq: (other) =>

        return @x == other.x and @y == other.y


    --- @brief Operator overload : tostring a
    ---
    __tostring: =>

        return "Vector(#{@x}; #{@y})"





--- @brief A 2D rectangle, constructed by 2 vectors.
---
--- Public members :
---   - a : The top-left corner's position.
---   - b : The bottom-right corner's position.
---
--- Properties :
---   - size [get, set] : Get/set the size of the rectangle.
---   - center [get, set] : Get/set the center vector of the rectangle.
---
--- Building table arguments (processed in this order) :
---   - a : The top-left corner's position.
---   - b : The bottom-right corner's position.
---   - size : The size of the rectangle.
---   - center : The center of the rectangle.
---
class Rectangle extends Object


    --- @brief Create a new instance from a building table.
    ---
    --- @param t : Building table.
    ---
    new: (t = {}) =>

        super t

        @type = "Rectangle"

        @a = @_opt t.a, Vector!
        @b = @_opt t.b, Vector!


        @property "size", "getSize", "setSize"
        @property "center", "getCenter", "setCenter"


        if t.size

            @set "size", t.size


        if t.center

            @set "center", t.center


    ---@brief Create a new instance from a table of data(a, b)
    ---
    --- Syntax:
    ---   - Rectangle\fromData {a: vector, b: vector}
    ---
    --- @param data : Table of positions(a, b)
    ---
    --- @return The created rectangle.
    ---
    @fromData: (data) =>

      return Rectangle {a: data.a, b: data.b}


    --- @brief Get the serialization of the rectangle.
    ---
    --- @return The serialized rectangle as a table {a: vector, b: vector}.
    ---
    getData: =>

      return {a: @a, b: @b}


    --- @brief @get "size"
    ---
    getSize: =>

        return @b - @a


    --- @brief @set "size"
    ---
    setSize: (size) =>

        @b = @a + size




    --- @brief @get "center"
    ---
    getCenter: =>

        return @a + @size / 2


    --- @brief @set "center"
    ---
    setCenter: (center) =>

        @a = center - @size / 2




    --- @brief Check if the given vector is in the current rectangle.
    ---
    --- @param vec : The vector.
    --- @return True if the vector is in the rectangle.
    ---
    contains: (vec) =>

        unless @a.x < vec.x and @b.x > vec.x and @a.y < vec.y and @b.y > vec.y

            return false

        return true


    --- @brief Check if the given rectangle intersects the current one.
    ---
    --- @param rect : The second rectangle.
    --- @param dest : The rectangle where to save the intersection rectangle
    ---               (optional).
    ---
    --- @return True if the rectangles intersect.
    ---
    intersect: (rect, dest=nil) =>

        left = max @a.x, rect.a.x
        top = max @a.y, rect.a.y
        right = min @b.x, rect.b.x
        bottom = min @b.y, rect.b.y

        if left < right and top < bottom

            if dest

                dest.a = Vector\from left, top
                dest.b = Vector\from right, bottom

            return true


        return false


    __tostring: =>

        return "Rectangle(Pos: #{@a}; Size: #{@get 'size'})"



--- @brief A linear transformation matrix.
---
--- @note Only usable for computing and can't be converted to a Transform.
---
class Matrix extends Object


    --- @brief Create a new instance.
    ---
    --- @param a : Nil, or a 3x3 indexed table.
    ---
    new: (a = nil) =>

        super!

        @type = "Matrix"


        @m = {
            1, 0, 0,
            0, 1, 0,
            0, 0, 1
        }


        if a == nil

            return


        if type(a) == "table" and #a == 16

            @m = {
                a[1], a[2], a[3]
                a[4], a[5], a[6]
                a[7], a[8], a[9]
            }


        else

            error "Invalid arguments."



    --- @brief Create a copy of the given matrix.
    ---
    --- @return A copy of the given matrix.
    ---
    @copy: (m) =>

        return Matrix m.m




    --- @brief Get the inverted matrix.
    ---
    --- @return The inverted matrix.
    ---
    getInverted: =>

        det  = @m[1] * ( @m[5] * @m[9] - @m[8] * @m[6] )
        det -= @m[2] * ( @m[4] * @m[9] - @m[6] * @m[7] )
        det += @m[3] * ( @m[4] * @m[8] - @m[5] * @m[7] )


        if det != 0

            m = Matrix!


            m.m[1] =  ( @m[5] * @m[9] - @m[6] * @m[8] ) / det
            m.m[4] = -( @m[2] * @m[9] - @m[3] * @m[8] ) / det
            m.m[7] =  ( @m[2] * @m[6] - @m[3] * @m[5] ) / det

            m.m[2] = -( @m[4] * @m[9] - @m[6] * @m[7] ) / det
            m.m[5] =  ( @m[1] * @m[9] - @m[3] * @m[7] ) / det
            m.m[8] = -( @m[1] * @m[6] - @m[3] * @m[4] ) / det

            m.m[3] =  ( @m[4] * @m[8] - @m[5] * @m[7] ) / det
            m.m[6] = -( @m[1] * @m[8] - @m[2] * @m[7] ) / det
            m.m[9] =  ( @m[1] * @m[5] - @m[2] * @m[4] ) / det


            return m

        else

            return Matrix!




    --- @brief Transform a vector.
    ---
    --- @param vec : The vector to transform.
    ---
    --- @return The transformed vector.
    ---
    transformVector: (vec) =>

        -- | e0 e3 e6 |
        -- | e1 e4 e7 |
        -- | e2 e5 e8 |

        fx = @m[1] * vec.x + @m[4] * vec.y + @m[7]
        fy = @m[2] * vec.x + @m[5] * vec.y + @m[8]

        return Vector\from(fx, fy)


    --- @brief Transform a 2D rectangle.
    ---
    --- @param rect : The rectangle to transform.
    ---
    --- @return The transformed rectangle.
    ---
    transformRect: (rect) =>

        pos = rect.a
        size = rect\get "size"

        points = {
            @transformVector(pos.x,          pos.y)
            @transformVector(pos.x,          pos.y + size.y)
            @transformVector(pos.x + size.x, pos.y)
            @transformVector(pos.x + size.x, pos.y + size.y)
        }

        left = points[1].x
        right = points[1].x
        top = points[1].y
        bottom = points[1].y


        for _, p in ipairs points

            if p.x < left
                left = p.x
            elseif p.x > right
                right = p.x

            if p.y < top
                top = p.y
            elseif p.y > bottom
                bottom = p.y

        return Rectangle {a: Vector\from(left, top), b: Vector\from(right, bottom)}




    --- @brief Combine the current matrix with the given one.
    ---
    --- @param m : The second matrix.
    ---
    --- @return self
    ---
    combine: (m) =>

        m = m.m

        c = { }

        c[1] = @m[1] * m[1] + @m[4] * m[2] + @m[7] * m[3]
        c[4] = @m[1] * m[4] + @m[4] * m[5] + @m[7] * m[6]
        c[7] = @m[1] * m[7] + @m[4] * m[8] + @m[7] * m[9]

        c[2] = @m[2] * m[1] + @m[5] * m[2] + @m[8] * m[3]
        c[5] = @m[2] * m[4] + @m[5] * m[5] + @m[8] * m[6]
        c[8] = @m[2] * m[7] + @m[5] * m[8] + @m[8] * m[9]

        c[3] = @m[3] * m[1] + @m[6] * m[2] + @m[9] * m[3]
        c[6] = @m[3] * m[4] + @m[6] * m[5] + @m[9] * m[6]
        c[9] = @m[3] * m[7] + @m[6] * m[8] + @m[9] * m[9]



        for i, v in ipairs c

            @m[i] = v


        return self


    --- @brief Get the combine operation of the current and the given matrix.
    ---
    --- @param m : Second matrix.
    ---
    --- @return The transformed matrix.
    ---
    getCombined: (m) =>

        return Matrix(@m)\combine m




    --- @brief Apply a translation matrix on the current one.
    ---
    --- @param vec : The translation vector.
    ---
    --- @return self
    ---
    translate: (vec) =>

        m = Matrix {

            1,     0, 0,
            vec.x, 1, 0,
            vec.y, 0, 1

        }

        return @combine m




    --- @brief Apply a rotation matrix on the current one.
    ---
    --- @param angle : The rotation angle.
    ---
    --- @param self
    ---
    rotate: (angle) =>

        rad = angle * math.pi / 180

        c = cos angle
        s = sin angle

        m = Matrix {

            c,  s, 0,
            -s, c, 0,
            0,  0, 1

        }

        return @combine m




    --- @brief: Apply a scaling matrix on the current one.
    ---
    --- @param vec : The scaling vector.
    ---
    --- @return self
    ---
    scale: (vec) =>

        m = Matrix {

            vec.x, 0,     0,
            0,     vec.y, 0,
            0,     0,     1

        }

        return @combine m




    --- @brief Apply a shearing matrix on the current one.
    ---
    --- @param vec : The shearing vector.
    ---
    --- @return self.
    ---
    shear: (vec) =>

        m = Matrix {

            1,     vec.x, 0,
            vec.y, 1,     0,
            0,     0,     1

        }

        return @combine m




    --- @brief Set the matrix with transformations values.
    ---
    --- @param p : The position.
    --- @param rot : The rotation.
    --- @param s : The scale.
    --- @param o : The origin.
    --- @param k : The shearing.
    ---
    setTransform: (p, rot, s, o, k) =>

        co = cos rot
        si = sin rot


        @m = {
            1, 0, 0,
            0, 1, 0,
            0, 0, 1
        }


        @m[1] = co * s.x - k.y * si * s.y
        @m[4] = si * s.x + k.y * co * s.y
        @m[2] = k.x * co * s.x - si * s.y
        @m[5] = k.x * si * s.x + co * s.y
        @m[3] = p.x - o.x * @m[1] - o.y * @m[2]
        @m[6] = p.y - o.x * @m[4] - o.y * @m[5]




--- @brief A 2D transformation.
---
--- @note Only usable with Love2D coordinate system and can be converted to a
---     Matrix
---
--- Public members :
---   - position : The position vector.
---   - origin : The origin vector.
---   - scale : The scale vector.
---   - shear : The shear vector.
---   - rotation : The rotation angle.
---
--- Building table :
---   - position : The position vector.
---   - origin : The origin vector.
---   - scale : The scale vector.
---   - shear : The shear vector.
---   - rotation : The rotation angle.
---   - x, y : The position.
---   - ox, oy : The origin.
---   - sx, sy : The scale.
---   - r : The rotation.
---
class Transform extends Object


    --- @brief Create a new instance from a building table.
    ---
    --- @param t : The building table.
    ---
    new: (t = {}) =>

        super t

        @type = "Transform"

        @position = @_opt t.position, Vector!
        @origin = @_opt t.origin, Vector!
        @scale = @_opt t.scale, Vector\from 1, 1
        @shear = @_opt t.shear, Vector!

        @rotation = @_opt t.rotation, 0

        @floor = @_opt t.floor, false

        @_matrix = nil
        @_inverted_matrix = nil


        @property "position", "getPosition", "setPosition"
        @property "origin", "getOrigin", "setOrigin"
        @property "scale", "getScale", "setScale"
        @property "shear", "getShear", "setShear"
        @property "rotation", "getRotation", "setRotation"

        @property "x", "getX", "setX"
        @property "y", "getY", "setY"
        @property "ox", "getOriginX", "setOriginX"
        @property "oy", "getOriginY", "setOriginY"
        @property "sx", "getScaleX", "setScaleX"
        @property "sy", "getScaleY", "setScaleY"
        @property "kx", "getShearX", "setShearX"
        @property "ky", "getShearY", "setShearY"


        if t.x and t.y

            @position = Vector\from t.x, t.y

        if t.ox and t.oy

            @origin = Vector\from t.ox, t.oy

        if t.sx and t.sy

            @origin = Vector\from t.sx, t.sy

        if t.kx and t.ky

            @shear = Vector\from t.kx, t.ky

        if t.r

            @rotation = t.r


    --- @brief Create a new copy of the given instance.
    ---
    --- @param other : The instance to copy.
    --- @return The created instance.
    ---
    @copy: (other) =>

        return Transform {
            position: Vector\copy other.position
            origin: Vector\copy other.origin
            scale: Vector\copy other.scale
            shear: Vector\copy other.shear
            rotation: other.rotation
        }




    --- @brief Get the transform into the love.graphics.draw format.
    ---
    --- @return The last arguments for love.graphics.draw.
    ---
    toArgs: =>

        x, y = @position.x, @position.y
        r = @rotation
        sx, sy = @scale.x, @scale.y
        ox, oy = @origin.x, @origin.y
        kx, ky = @shear.x, @shear.y

        if @floor

            return floor(x), floor(y), r, sx, sy, floor(ox), floor(oy), kx, ky

        else

            return x, y, r, sx, sy, ox, oy, kx, ky




    --- @brief Apply the transform.
    ---
    apply: =>

        if @floor

            lg.translate floor(@position.x), floor(@position.y)

        else

            lg.translate @position.x, @position.y

        lg.rotate @rotation
        lg.scale @scale.x, @scale.y
        lg.shear @shear.x, @shear.y

        if @floor

            lg.translate floor(-@origin.x), floor(-@origin.y)

        else

            lg.translate -@origin.x, -@origin.y


    --- @brief Undo the transform.
    ---
    undo: =>

        if @floor

            lg.translate floor(@origin.x), floor(@origin.y)

        else

            lg.translate @origin.x, @origin.y

        lg.shear -@shear.x, -@shear.y
        lg.scale 1 / @scale.x, 1 / @scale.y
        lg.rotate -@rotation

        if @floor

            lg.translate floor(-@position.x), floor(-@position.y)

        else

            lg.translate -@position.x, -@position.y




    --- @brief Get the matrix of the transformation.
    ---
    --- @return The matrix corresponding to the actual transformation.
    ---
    getMatrix: =>

        if @_matrix != nil

            return @_matrix


        m = Matrix!

        m\setTransform @position, @rotation, @scale, @origin, @shear

        @_matrix = m
        return m


    --- @brief Get the matrix of the inverted transformation.
    ---
    --- @return The matrix corresponding to the actual transformation inverted.
    ---
    getInvertedMatrix: =>

        if @_inverted_matrix != nil

            return @_inverted_matrix


        m = Matrix!

        m\setTransform @position, @rotation, @scale, @origin, @shear

        @_inverted_matrix = m\getInverted!
        return m




    --- @brief Notify the transform that one of its value has changed.
    ---
    notifyChange: =>

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the position of the transform.
    ---
    getPosition: =>

        return Vector\copy @position


    --- @brief Set the position of the transform.
    ---
    setPosition: (v) =>

        @position = Vector\copy v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the origin of the transform.
    ---
    getOrigin: =>

        return Vector\copy @origin


    --- @brief Set the origin of the transform.
    ---
    setOrigin: (v) =>

        @origin = Vector\copy v

        @_matrix = nil
        @_inverted_matrix = nil





    --- @brief Get the scale of the transform.
    ---
    getScale: =>

        return Vector\copy @scale


    --- @brief Set the scale of the transform.
    ---
    setScale: (v) =>

        @scale = Vector\copy v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the shearing of the transform.
    ---
    getShear: =>

        return Vector\copy @shear


    --- @brief Set the shearing of the transform.
    ---
    setShear: (v) =>

        @shear = Vector\copy v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the rotation of the transform.
    ---
    getRotation: =>

        return @rotation


    --- @brief Set the rotation of the transform.
    ---
    setRotation: (v) =>

        @rotation = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the X position of the transform.
    ---
    getX: =>

        return @position.x


    --- @brief Set the X position of the transform.
    ---
    setX: (v) =>

        @position.x = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the Y position of the transform.
    ---
    getY: =>

        return @position.y


    --- @brief Set the Y position of the transform.
    ---
    setY: (v) =>

        @position.y = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the X origin of the transform.
    ---
    getOriginX: =>

        return @origin.x


    --- @brief Set the X origin of the transform.
    ---
    setOriginX: (v) =>

        @origin.x = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the Y origin of the transform.
    ---
    getOriginY: =>

        return @origin.y


    --- @brief Set the Y origin of the transform.
    ---
    setOriginY: (v) =>

        @origin.y = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the X scale of the transform.
    ---
    getScaleX: =>

        return @scale.x


    --- @brief Set the X scale of the transform.
    ---
    setScaleX: (v) =>

        @scale.x = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the Y scale of the transform.
    ---
    getScaleY: =>

        return @scale.y


    --- @brief Set the Y scale of the transform.
    ---
    setScaleY: (v) =>

        @scale.y = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the X shearing of the transform.
    ---
    getShearX: =>

        return @shear.x


    --- @brief Set the X shearing of the transform.
    ---
    setShearX: (v) =>

        @shear.x = v

        @_matrix = nil
        @_inverted_matrix = nil




    --- @brief Get the Y shearing of the transform.
    ---
    getShearY: =>

        return @shear.y


    --- @brief Set the Y shearing of the transform.
    ---
    setShearY: (v) =>

        @shear.y = v

        @_matrix = nil
        @_inverted_matrix = nil




{
    :Vector,
    :Rectangle,
    :Matrix,
    :Transform
}
