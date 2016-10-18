import Backend from require "framework.data.backend"

table_gen = (list, keys, n) ->
    n = n or 1
    list[keys[n]] = {}

    if #keys != n then
        n += 1
        table_gen list[keys[n - 1]], keys, n

parse_ini = (data, rec_sec) ->
    output = ""
    for section, param in pairs data
        if "table" == type param
            unless rec_sec
                output ..= ("\n[%s]\n")\format section
            else
                output ..= ("\n[%s.%s]\n")\format rec_sec, section
            for k, v in pairs param
                unless "table" == type v
                    output ..= ("%s = %s\n")\format k, tostring v
                else
                    unless rec_sec
                        rec_sec = ("%s.%s")\format section, k
                    else
                        rec_sec = ("%s.%s.%s")\format rec_sec, section, k
                    output ..= ("\n[%s]\n")\format rec_sec
                    output ..= parse_ini v, rec_sec
        else
            output ..= ("%s = %s\n")\format section, tostring param

    output

class IniBackend
    new: (@namespace = "data") =>

    save: (data) =>
        ini_data = parse_ini {[@namespace]: data}
        love.filesystem.write @path, ini_data
        ini_data

    load: =>
        data = love.filesystem.read @path

        output = {}
        section = ""

        i = 1 -- for keeping track of nested layer
        for line in (data .. "\n")\gmatch "(.-)\n"
            temp_section = line\match "^%[([^%[%]]+)%]$"

            if temp_section
                t = output
                for w, d in temp_section\gfind "([%w_]+)(.?)"
                    t[w] = t[w] or {}
                    t = t[w]

                section = temp_section

            p, v = line\match "^([%w|_]+)%s-=%s-(.+)$"

            if p and v
                if tonumber v
                    v = v
                elseif v == "true"
                    v = true
                elseif v == "false"
                    v = false

                if tonumber p
                    p = tonumber p

                t = output
                for w, d in section\gfind "([%w_]+)(.?)"
                    if d == "."
                        t[w] = t[w]
                        t = t[w]
                    else
                        t[w][p] = v

        output[@namespace]

    setPath: (@path) =>

{
    :IniBackend,
}
