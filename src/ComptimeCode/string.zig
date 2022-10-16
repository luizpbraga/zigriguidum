//
const std = @import("std");
const print = std.debug.print;
//
const Str = []const u8;
//
fn foo(comptime s: Str, comptime n: usize) Str {
    return s ** n;
}
//
pub fn main() !void {
    print("{s}", .{foo("abc", 3)});
}
