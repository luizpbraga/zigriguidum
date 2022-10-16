//
const std = @import("std");
const print = std.debug.print;

fn foo(_: i32) void {}
//
pub fn main() void {
    print("{s}", .{""});

    foo(1);
}
