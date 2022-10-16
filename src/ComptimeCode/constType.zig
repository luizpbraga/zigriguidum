//
const std = @import("std");
const print = std.debug.print;
//
const Foo = struct {
    v: i32,

    fn y(this: []@This()) void {
        _ = this;
    }
};

var arr = [_]Foo{
    .{ .v = 1 },
    .{ .v = 1 },
    .{ .v = 1 },
    .{ .v = 1 },
    .{ .v = 1 },
};

const SomeFoo = struct { T: type };

pub fn main() !void {
    comptime var s: SomeFoo = .{ .T = Foo };
    _ = s;
}
