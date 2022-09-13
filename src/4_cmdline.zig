//
const std = @import("std");
//
test "command line" {
    var arg = try std.process.argsAlloc(std.heap.page_allocator);
    if (arg.len > 1) std.debug.print("{s}", .{arg});
}
