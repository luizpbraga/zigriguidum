const std = @import("std");
const print = std.debug.print;

const trait = std.meta.trait; // !!!!

fn foo(comptime T: type, f: T, g: T) !T {
    return if (trait.isNumber(T)) g + f else error.NAN;
}

fn selectType(variable: anytype) void {
    switch (@TypeOf(variable)) {
        i32 => print("is i32", .{}),
        f64 => print("is f32", .{}),
        else => {},
    }
}

pub fn main() !void {
    print("{}", .{try foo(i32, 1, 1)});
    selectType(try foo(f64, 1, 1));
}
