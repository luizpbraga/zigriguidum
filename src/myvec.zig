const std = @import("std");
const print = std.debug.print;
//
fn Vec(comptime T: type, comptime size: usize) type {
    return struct {
        el: @Vector(size, T),

        fn set(self: *@This(), n: T) void {
            self.el = @splat(size, n);
        }

        fn at(self: *@This(), n: usize) T {
            return self.el[n];
        }

        fn add(self: *@This(), other: *@This()) @This() {
            return .{ .el = self.el + other.el };
        }

        fn sub(self: *@This(), other: *@This()) @This() {
            return .{ .el = self.el - other.el };
        }

        fn x(self: *@This(), n: T) @This() {
            return .{ .el = @splat(size, n) * self.el };
        }
    };
}

pub fn main() !void {
    print("{s}", .{""});

    var v: Vec(i32, 4) = undefined;
    v.el = .{ 1, 2, 3, 4 };
    std.debug.print("{}\n", .{v.el});
    std.debug.print("{}\n", .{v.at(1)});
    v.set(1);
    std.debug.print("{}\n", .{v.el});
    v = v.add(&v);
    std.debug.print("{}\n", .{v.el});
    v = v.x(5);
    std.debug.print("{}\n", .{v.el});
}
