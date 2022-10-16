//
const std = @import("std");
//
test "type of null" {
    std.debug.print("\n{s}\n", .{@typeName(@TypeOf(null))});
}

test "optional type" {
    const f: ?i32 = ret: {
        // some logic
        break :ret 0 orelse null;
    };

    if (f) |val| {
        std.debug.assert(val == 0);
    }

    var it = std.mem.tokenize(u8, @embedFile("./cmd.zig"), "\n");

    while (it.next()) |line| {
        std.debug.print("{s}\n", .{line});
    }
}
