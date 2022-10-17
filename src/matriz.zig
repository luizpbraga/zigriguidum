// matrixes multiplication
const std = @import("std");
const print = std.debug.print;
//
// a[m][n] X b[n][l] = c[m][l]
fn prod(comptime T: type, a: [][]T, b: [][]T) [][]T {
    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;
    var row = a.len;
    var col = b[0].len;
    var c: [row][col]T = undefined;

    while (i < row) : (i += 1) {
        while (j < col) : (j += 1) {
            while (k < col) : (k += 1) {
                c[i][j] += a[i][k] + b[k][j];
            }
            k = 0;
        }
        j = 0;
    }

    return c;
}

fn matriz(
    comptime T: type, //
    comptime row: usize,
    comptime n: usize, //
    comptime col: usize, //
    a: [row][n]T,
    b: [n][col]T,
) [row][col]T {
    var i: usize = 0;
    var j: usize = 0;
    var k: usize = 0;

    var c: [row][col]T = undefined;

    while (i < row) : (i += 1) {
        while (j < col) : (j += 1) {
            while (k < col) : (k += 1) {
                c[i][j] += a[i][k] + b[k][j];
            }
            k = 0;
        }
        j = 0;
    }
    return c;
}

fn foo(comptime T: type, a: []const T, b: []const T) []const T {
    return a ++ b;
}

pub fn main() !void {
    comptime var a = [_]i32{ 1, 2, 3, 4 };
    comptime var b = [_]i32{ 1, 2, 3, 4 };
    print("{d}", .{comptime foo(i32, &a, &b)});

    var s: [5]u8 = .{ 1, 2, 3, 4, 5 };
    _ = s;
}
