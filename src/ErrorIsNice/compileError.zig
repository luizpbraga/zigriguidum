const std = @import("std");
const print = std.debug.print;

fn max(a: anytype, b: @TypeOf(a)) @TypeOf(a) {
    if (std.meta.trait.isNumber(@TypeOf(a)))
        return if (a > b) a else b;
    @compileError("err");
}

pub fn main() void {
    print("{d} {}", .{ max("a", "a"), std.meta.trait.isNumber(@TypeOf("a")) });
}
