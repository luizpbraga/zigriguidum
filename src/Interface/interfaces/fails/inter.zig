//
const std = @import("std");
const print = std.debug.print;
//
const Inter = struct {
    fooFn: fn (self: *const Inter) void,

    pub inline fn foo(comptime self: *const Inter) void {
        self.fooFn(self);
    }
};

const A = struct {
    i: Inter = Inter{ .fooFn = foo },
    a: u8 = 0,

    fn foo(comptime _: *const Inter) void {
        print("{s}", .{"Ola A!"});
    }
};

const B = struct {
    i: Inter = Inter{ .fooFn = foo },
    b: u8 = 1,

    fn foo(comptime _: *const Inter) void {
        // const self = @This(); Interface
        print("{s}", .{"Ola B!"});
    }
};

pub fn main() !void {
    comptime var in: Inter = (A{}).i;
    in.foo();
    in = (B{}).i;
    in.foo();
}
