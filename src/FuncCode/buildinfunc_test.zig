//
const std = @import("std");
//
fn foo(noalias x: i32) void {
    _ = x;
}

test "build in 1" {
    const x = 1.0;
    comptime foo(x);
}
