//
const std = @import("std");
const print = std.debug.print;
//
const A = struct {
    a: i32,
    fn new(a: i32) A {
        return .{
            .a = a,
        };
    }
};

const B = struct {
    b: i32,
    fn new(b: i32) B {
        return .{
            .b = b,
        };
    }
};

fn foo(comptime ab: anytype) bool {
    return @hasDecl(@TypeOf(ab), "new");
}

fn bar(comptime any: anytype) @TypeOf(any) {
    return switch (@TypeOf(any)) {
        comptime_int, usize, u8, u32, i8, i32, i64 => any,
        comptime_float, f32, f64 => any,
        else => unreachable,
    };
}

pub fn main() !void {
    const a = A{ .a = 1 };
    print("{} {}", .{ foo(a), bar(1) });
}
