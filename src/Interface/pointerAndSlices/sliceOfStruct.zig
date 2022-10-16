//
const std = @import("std");
const print = std.debug.print;
//

const MyType = struct {
    v: @Vector(3, f64),
    r: @Vector(3, f64),
};

var arr = [_]MyType{
    .{ .v = .{ 0, 0, 0 }, .r = .{ 0, 0, 0 } },
    .{ .v = .{ 1, 1, 1 }, .r = .{ 1, 1, 1 } },
};

fn foo(slice: []MyType) void {
    for (slice) |*t, i| {
        t.v = @Vector(3, f64){ 99, 99, 99 } + t.r;
        print("{d} {}", .{ i, t });
    }
}

pub fn main() !void {
    foo(&arr);
    print("\n\n\n{}", .{arr[1].v});
}
