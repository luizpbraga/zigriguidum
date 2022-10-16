const std = @import("std");

const A = struct {
    const Self = @This();

    a: i32,

    fFn: *const fn (comptime self: @This()) void,

    fn init(ptr: *anyopaque) Self {
        return .{ .a = 1, .fFn = struct {
            fn fImpl() void {
                const self = @ptrCast(@TypeOf(ptr), ptr);
            }
        }.fImpl };
    }
};

pub fn main() void {
    var i: i32 = 1;
    var p: *i32 = undefined;
    p = &i;
    var o: *anyopaque = undefined;
    o = p;
    var oi32 = @ptrCast(*i32, @alignCast(4, o));
    std.debug.print("{any} {}", .{ @TypeOf(oi32), oi32.* });
}
