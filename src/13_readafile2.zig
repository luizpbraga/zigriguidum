/// read a file
const std = @import("std");
const print = std.debug.print;
//
test "read a file 2" {
    const file = try std.fs.cwd().openFile("./split.zig", .{});
    defer file.close();

    const stat = try file.stat();
    var buffer = try std.heap.page_allocator.alloc(u8, stat.size);

    _ = try file.read(buffer);
    print("{s}", .{buffer});
}
