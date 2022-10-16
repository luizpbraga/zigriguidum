const std = @import("std");

fn add(a: i32, b: i32) i32 {
    return a + b;
}

fn allocate(comptime n: usize) [n]i32 {
    return undefined;
}

fn alloc(comptime T: type) T {
    return undefined;
}

pub fn main() void {
    // it's works in comp-time
    const len = comptime add(1, 1);
    std.debug.print("{}", .{@TypeOf(len)});
    // values can be coersed;
    var foo: [len]i32 = undefined;
    // auto comp time ?
    var bar: [add(1, 1)]i32 = undefined;
    _ = foo;
    _ = bar;

    var foobar = allocate(10);
    std.debug.print("{}", .{foobar.len});
    var foobar2 = alloc([10]i32);
    std.debug.print("{}", .{foobar2.len});
}
