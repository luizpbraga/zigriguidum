//
const std = @import("std");
const print = std.debug.print;
//
test "file info" {
    const file = try std.fs.cwd().statFile("./cmd.zig");
    const size = file.size;
    const time = @divFloor(file.atime, @as(i128, 1e9));

    inline for (@typeInfo(@TypeOf(file)).Struct.fields) |field| {
        // >?
        print("{}", .{field});
    }

    print("{d} {d}s", .{ size, time });
}
