//
const std = @import("std");
//

const Foo = struct {
    f: i32,
    y: *const fn (@This()) void = null,
    fn y(this: @This()) void {
        std.debug.print("{d}", .{this.f});
    }
};
const Bar = struct {
    b: i32,
    y: *const fn (@This()) void,
};

pub fn main() !void {
    const bb = Bar{
        .b = 10,
    };
    //const ff = Foo{ .f = 1 };

    // criou fptr sendo do Tipo Foo com o campo f igual a bb.b;
    var fptr = @fieldParentPtr(Foo, "f", &bb.b);
    var bptr = @fieldParentPtr(Foo, "y", &bb.y);
    fptr.y();
    bptr.y();
    !AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
}
