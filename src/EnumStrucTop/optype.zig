//
const std = @import("std");
const expect = std.testing.expect;
//
test "test 1\n" {
    var t: ?u8 = 1;
    if (t) |val| try expect(val == 1);

    var t2: ?u8 = null;

    if (t2) |val| try expect(val == 1) else std.debug.print("\nUnreachable\n", .{});

    if (t2) |val| try expect(val == 1) else std.debug.print("\nUnreachable\n", .{});
}
