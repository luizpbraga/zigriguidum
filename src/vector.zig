const std = @import("std");
const print = std.debug.print;
const Vb4 = @Vector(4, bool);

// fortran arrays >>>> zig arrays
pub fn main() !void {
    var v = @Vector(4, i32){ 1, 2, 3, 4 };
    v[0] = 0;
    v = v * v;
    v = @splat(4, @as(i32, 10)) * v;
    const sum = @reduce(.Add, v);
    v = @select(i32, Vb4{ true, false, false, false }, v, -v);
    print("{d} {d}", .{ v, sum });
}
