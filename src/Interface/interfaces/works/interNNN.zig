//
const std = @import("std");
const print = std.debug.print;

const Interface = struct {
    impl: *anyopaque,
    pickFn: *const fn (*anyopaque) i32,

    pub inline fn pick(iface: *const Interface) i32 {
        return iface.pickFn(iface.impl);
    }
};

pub fn foo(iface: Interface) void {
    std.debug.print("{d}", .{iface.pick()});
}
//

const A = struct {
    x: i32 = 100,

    pub fn interface(self: *A) Interface {
        return .{
            .impl = @ptrCast(*anyopaque, self),
            .pickFn = pick,
        };
    }

    fn pick(selfv: *anyopaque) i32 {
        var self = @ptrCast(*A, @alignCast(@alignOf(A), selfv));
        self.x += 1;
        return self.x;
    }
};

pub fn main() !void {
    var a = A{};
    const a_iface = a.interface();
    // ideal: foo(a) => o que temos: foo(a.interface())
    foo(a_iface);
}
