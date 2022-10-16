//
const std = @import("std");
const print = std.debug.print;
//
fn foo(i: i32, config: struct {
    op1: i32 = 0,
    op2: f32 = 0,
    op3: []const u8 = "keyword",
}) i32 {
    print("{d} {s}\n", .{ config.op2, config.op3 });
    return i + config.op1;
}

fn List(comptime T: type) type {
    return struct {
        value: T,
        next: ?List(T),

        fn len(self: *const List(T)) usize {
            return 1 + if (self.next) |next| next.len() else 0;
        }
    };
}

fn GenType(comptime T: type, comptime val: T) struct {
    const This = @This();
    v: T,
    fn foo(this: @This()) anyerror!T {
        return this.v;
    }
} {
    return .{ .v = val };
}

pub fn main() !void {
    var v = GenType(i32, 1);
    print("{d} {d}", .{ foo(1, .{}), v.v });
}
