//
const std = @import("std");
const print = std.debug.print;

//
pub fn main() !void {
    const file = try std.fs.cwd().openFile("./TODO.md", .{});

    const stat = try file.stat();

    var buffer = try std.heap.page_allocator.alloc(u8, stat.size);

    _ = try file.read(buffer);

    print("{s}", .{buffer});

    defer file.close();
}
