import IniBackend from require "framework.data"

ini_pipe = IniBackend!
ini_pipe\setPath "hello.ini"

test_data = {
    key: "value",
    nested: {
        key: "value",
        more_nested: {
            special_key: 42,
            even_more_nested: {
                please_work: "yay!",
                yep_its_working_nicely: {
                    really: true,
                    reallyreally: "almost sure now ..!",
                    inverted: "wut?",
                    what_order_is_this: false,
                }
            },
        },
    },
}

ini_pipe\save test_data

print ini_pipe\load!.nested.key -- stdout > "value"
