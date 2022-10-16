//
const std = @import("std");
const print = std.debug.print;
//

const C = struct {
    const Self = @This();
    it: *anyopaque,
    fooFn: *const fn (*anyopaque) void,

    // init retorna Self com foo reclarada
    pub fn init(prt: *anyopaque) Self {
        return .{ .fooFn = struct {
            pub fn fooImpl(pointer: *anyopaque) void {
                const self = @fieldParentPtr(Self, "foo", pointer);
                self.fooFn();
            }
        }.fooImpl, .it = prt };
    }

    pub fn foo(self: *Self) void {
        self.fooFn(self);
    }
};

const A = struct {
    const Self = @This();
    fn foo(self: *Self) void {
        C.init(self);
    }
};

pub fn main() !void {}
