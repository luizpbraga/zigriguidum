const std = @import("std");

const TheInterface = struct {
    // Fields
    fooFn: fn (comptime self: *const TheInterface, a: i32) void,

    //Methods
    pub inline fn foo(comptime self: *const TheInterface, a: i32) void {
        self.fooFn(self, a);
    }
};

const A = struct {
    // Field
    theInterface: TheInterface = TheInterface{ .fooFn = foo },
    // Methods
    pub fn foo(comptime theInterface: *const TheInterface, a: i32) void {
        _ = theInterface;
        std.log.info("MSG {d}", .{a});
    }
};

const B = struct {
    // Fields
    theInterface: TheInterface = TheInterface{ .fooFn = foo },
    f: u8,
    // Methods
    pub fn foo(comptime theInterface: *const TheInterface, a: i32) void {
        const self = @fieldParentPtr(B, "theInterface", theInterface);
        if (self.f < 2) {
            std.log.info("MSG {d}", .{a});
        } else std.log.info("Bark", .{});
    }
};

pub fn main() void {
    const c = [2]TheInterface{ (A{}).theInterface, (B{ .f = 1 }).theInterface };
    c[0].foo(2);
    const self = @fieldParentPtr(B, "theInterface", TheInterface);
    _ = self;
}
