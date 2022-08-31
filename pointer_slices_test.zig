//
const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;
//

// slice of *VARriable* u8
fn letmeseeit(v: []u8) void {
    for (v) |val| print("{d} ", .{val});
}

fn makeit5(v: []u8) void {
    for (v) |*val| val.* = 5;
}

fn constLetmeseeit(v: []const u8) void {
    for (v) |val| print("{d} ", .{val});
}

test "pointers" {
    var v = [_]u8{ 1, 2, 3, 4 };
    const const_v = [_]u8{ 1, 2, 3, 4 };

    // non-const
    letmeseeit(v[0..]);
    letmeseeit(&v);
    makeit5(&v);
    letmeseeit(v[0..]);

    // const
    // *const []u8 -> []const u8
    constLetmeseeit(&const_v);
    // const [4]u8 -> const []u8
    constLetmeseeit(const_v[0..]);
}

test "strings are pointers" {
    const str = "ola!";
    try expect(@TypeOf(str) == *const [4:0]u8);
    //const str2 = [4:0]u8{ 97, 98, 99, 100 };
    //try expect(str2 != "abcd");
}
