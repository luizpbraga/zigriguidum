//
const std = @import("std");
const print = std.debug.print;
//

fn add(comptime T: type, a: T, b: T) T {
    if (T != []const u8) return a + b;
    return a ++ b;
}

test "comp time 1" {
    print("\n {d} \n", .{add(u8, 1, 1)});
    // slices concat need to be knew at compile time: why?
    print("\n {s} \n", .{comptime add([]const u8, "a", "b")});
}

const string = union {
    str1: []const u8,
    str2: []u8,
};

fn strFunc1(s: []const u8) void {
    _ = s;
}

test "string coersion" {
    const v = "string1";

    strFunc1(v); // Ok
    comptime std.debug.assert(@TypeOf(v) == *const [7:0]u8);

    const v1 = [3]u8{ 'a', 'b', 'c' };

    std.debug.print("{s}", .{v1});
    // Wee have to use the & op to coerse an array ([3]{ ... }) to a slice ([]u8)
    strFunc1(&v1);

    //const v2 = []u8{ 'a', 'b', 'c' }; // Error: Slices dont suport Array initialization syntax
    //strFunc1(v2);
}
