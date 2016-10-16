
import ObjectReference, MemberReference from require "framework.core"


reference = nil


do
    object = {}
    reference = ObjectReference object

print "Object valid : ", reference\isValid!


collectgarbage!


print "Object still valid : ", reference\isValid!
print ""



do
    object = {member: 42}
    reference = MemberReference object, "member"

print "Member valid : ", reference\isValid!

if reference\isValid!
    print " -> Member's value : ", reference\get "value"


collectgarbage!


print "Member still valid : ", reference\isValid!
print ""


do
    object = {
        hello: => print "Method -> Hello world !"
    }
    reference = MemberReference object, "hello"

print "Method valid : ", reference\isValid!

if reference\isValid!
    print "Calling method."
    reference!

collectgarbage!

print "Method still valid : ", reference\isValid!
