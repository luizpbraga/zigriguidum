//
const std = @import("std");
//
const v = 1;
const s = 2;

test "ID" {
    try std.testing.expect(@ptrToInt(&v) == @ptrToInt(&s));
}
