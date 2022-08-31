//
const std = @import("std");
const print = std.debug.print;
//
test "Casting #1:\n" {
    // comptime_int
    const v = 1;
    //
    var i: usize = v;
    _ = i;
    //
    var j: i32 = v;
    _ = j;

    var arr: [5]u8 = .{v} ** 5;
    _ = arr;
}
