//
const std = @import("std");
const print = std.debug.print;
//
pub fn main() !void {
    print("{s}", .{""});
    var s: i32 = try std.io.getStdIn().reader().readIntNative(i32);
    print("{d}", .{s});
}
