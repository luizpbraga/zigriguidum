//
const std = @import("std");
const print = std.debug.print;
//
test "strings func" {
    print("{d}", .{witchone(-100)});
    print("{d}", .{witchOne(-100)});
    count(words);
    //    countslice(foo[0..]);
    count(foo);
    //count("ola"[0..]);
}

fn witchone(a: i32) i32 {
    // b can not bee (JOKE) comptime
    var b: i32 = undefined;

    // runtime code:
    if (a < 10) {
        b = a;
    } else {
        b = 100;
    }

    return b;
}

fn witchOne(a: i32) i32 {
    return if (a < 10) a else 100;
}

fn count(v: anytype) void {
    print("\n{}\n", .{@TypeOf(v)});
    // WHY: why tuples fields must be knew at comptime?
    inline for (v) |el| _ = el;
}

fn countslice(v: []const u8) void {
    print("\n{}\n", .{@TypeOf(v)});
    // WHY: why tuples fields must be knew at comptime?
    inline for (v) |el| _ = el;
}
const words = .{ "ola", "sheatsheet", "shitshit", "maracujá" };
const foo = [2][]const u8{ "ola", "mundo" };
