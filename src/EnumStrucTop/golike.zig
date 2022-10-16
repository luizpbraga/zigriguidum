//
const std = @import("std");
const print = std.debug.print;

//
//
fn println(comptime fmt: []const u8, args: anytype) void {
    print(fmt ++ "\n", args);
}

fn Foo(comptime T: type, comptime _x: T, comptime _y: T) type {
    return struct { x: T = _x, y: T = _y };
}

pub fn main() !void {
    const v: [3]i32 = .{0} ** 3; // .{0} ++ .{0} ++ .{0} = .{ 0, 0, 0 }
    _ = v;

    var s = [2]struct {
        x: i32,
        y: i32,
    }{
        .{ .x = 1, .y = 1 },
        .{ .x = 2, .y = 2 },
    };

    println("{any}", .{s});
    println("{any}", .{s});
}
