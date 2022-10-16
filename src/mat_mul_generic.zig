//
const std = @import("std");
const print = std.debug.print;
//

fn M(comptime T: type, comptime d1: usize, comptime d2: usize) type {
    return [d1][d2]T;
}

fn prod(comptime T: type, comptime a: anytype, comptime b: anytype) !M(T, a.len, b[0].len) {
    //
    if (T != @typeInfo(@typeInfo(@TypeOf(a)).Array.child).Array.child or
        T != @typeInfo(@typeInfo(@TypeOf(b)).Array.child).Array.child)
        return error.TypeError;

    const n = if (a[0].len == b.len) a[0].len else return error.ShapeError;

    const row = a.len; //x = [row][col]T => x.len = x=row; x[0].len = col;
    const col = b[0].len;

    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;
    var c: M(T, row, col) = .{.{0} ** col} ** row;

    while (i < row) : ({
        i += 1;
        j = 0;
    })
        while (j < col) : ({
            j += 1;
            k = 0;
        }) {
            while (k < n) : (k += 1)
                c[i][j] = a[i][k] + b[k][j];
        };

    return c;
}

pub fn main() !void {
    const a: M(i32, 4, 2) = .{.{ 1, 1 }} ** 4;
    const b: M(i32, 2, 4) = .{.{ 1, 1, 1, 1 }} ** 2;
    //const b: [1][2]i32 = undefined; // .{.{ 1, 1 }} ** 2;

    print("{d} {d} {}\n", .{ a.len, b[0].len, a[0].len == b.len });

    const c = try prod(i32, a, b);
    print("{d}", .{c});
}
