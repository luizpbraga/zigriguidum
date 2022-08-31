//
const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

const HumanError = error{
    DrinkTooMuch,
    DoDrugs,
    LoveMyFriedMother,
    // And the list go away ...
};

fn foo(p: People) HumanError!void {
    if (p.sex.?) {
        return HumanError.DoDrugs;
    }
}

const People = struct {
    //
    const This = @This();
    //
    name: *const [4:0]u8,
    age: u8 = 18,
    sex: ?bool = true,
    func: *const fn (This) HumanError!void = foo,

    fn callPeople(this: This) !void {
        try std.io.getStdOut().writer().print("{s}", .{this.name});
    }
};

test "some built-in functions" {
    var people = People{
        .name = "Luiz",
        .age = 26,
    };

    try people.callPeople();
}
