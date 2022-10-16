//
const std = @import("std");
const print = std.debug.print;

const Color = union(enum) {
    Red,
    Blue,
};

// core dump
fn ColorG(comptime T: type) type {
    return enum(T) {
        Red,
        Blue,
    };
}

fn retColor() type {
    return enum(u1) {
        Red,
        Blue,
    };
}

//
pub fn main() !void {
    print("{s}", .{""});

    const v = retColor().Red;
    print("{}", .{@TypeOf(v)});
    switch (v) {
        .Red => print("é red", .{}),
        else => {},
    }

    const foo: [10]u8 = .{10} ** 10;

    print("\n{d:1}\n", .{foo});
    for ([_]u0{0} ** 5) |_| print("{d}\n", .{foo});
}
