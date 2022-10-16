//
const std = @import("std");
const print = std.debug.print;
//
const p = 13;

const E = enum {
    f1,
    f2,

    fn is(v: E) @This() {
        return v;
    }

    fn eprint(me: i32) void {
        std.debug.print("{d}", .{me});
    }
};

pub fn main() !void {
    var e = E.is().eprint(1);
    print("{s}", .{""});
}
