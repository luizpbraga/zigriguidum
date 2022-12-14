/// read a file
const std = @import("std");
const Allocator = std.mem.Allocator;

test "read a file" {
    // #1
    const file = try std.fs.cwd().openFile("./README.md", .{});
    defer file.close();
    const stat = try file.stat();
    var buffer = try Allocator.alloc(std.heap.page_allocator, u8, stat.size);
    _ = try file.read(buffer);
    try std.io.getStdOut().writer().print("{s} ::::::::::::::::: \n", .{buffer});

    // #2
    const allfile = @embedFile("./README.md");
    try std.io.getStdOut().writer().print("{s} ::::::::::::::::: \n", .{allfile});
    // End!
}
