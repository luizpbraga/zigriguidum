//
const std = @import("std");
const print = std.debug.print;
//
test "strings are pointers\n" {
    var str1 = "ola mundo";
    const str2 = "ola mundo";
    print("\n", .{});
    print("{}\n", .{@TypeOf(str1)});
    print("{}\n", .{@TypeOf(str2)});
    print("{}\n", .{@TypeOf(str1.*)});
    print("{}\n", .{@TypeOf(str2.*)});
    print("{}\n", .{@TypeOf(&str1.*)});
    print("{}\n", .{@TypeOf(&str2.*)});
    print("{}\n", .{@TypeOf(str1[0])});
    print("{}\n", .{@TypeOf(str2[0])});
    print("{}\n", .{@TypeOf(str1[1..5])});
    print("{}\n", .{@TypeOf(str2[1..5])});
    print("{}\n", .{@TypeOf(str1[5..])});
    print("{}\n", .{@TypeOf(str2[5..])});
    print("{}\n", .{@TypeOf(str1[5..9])});
    print("{}\n", .{@TypeOf(str2[5..9])});
    // same val
    try std.testing.expect(std.mem.eql(u8, str1, str2));
    try std.testing.expect(std.mem.eql(u8, str1[0..], str2[0..]));
    try std.testing.expect(str1[0] == str2[0]);
    try std.testing.expect(str1.len == str2.len);
    // fuck const or var. same type
    try std.testing.expect(@TypeOf(str1) == @TypeOf(str2)); // *const [3:0]u8 == *const [3:0]u8
    try std.testing.expect(@TypeOf(str1[1]) == @TypeOf(str2[1])); // u8 == u8
    try std.testing.expect(@TypeOf(str1[1..]) == @TypeOf(str2[1..])); // *const [8:0]u8 == [8:0]u8
    try std.testing.expect(@TypeOf(str1.*) == @TypeOf(str2.*)); // [9:0]u8 == [9:0]u8
}

test "how to change an strings? \n" {
    // imutables by default
    var s = "ola mundo";
    var s2 = s.*; // [N:0]u8

    // Don't work
    //s[1] = 'O';
    // s2 = 'O' ++ s2[1..];

    s2 = "O".* ++ s2[1..].*;
    s2[4] = 'M';

    s = "O" ++ s[1..];
    s = s[0..4] ++ "M" ++ s[5..];

    print("{s} {s}\n", .{ s, s2 });

    var str = "0123456789".*;

    for (str) |*c| {
        c.* = 'a';
    }

    try std.testing.expect(std.mem.eql(u8, "a" ** 10, &str));
}

test "loop" {
    for ("a" ** 10) |_|
        print("loop\n", .{});

    for ([_]u0{0} ** 10) |_|
        print("loop\n", .{});

    for (.{0} ** 10) |_|
        print("loop\n", .{});

    const x = 32;

    var y: i32 = x + 1;
    var z: i64 = x + 2;

    _ = z + y;
}
