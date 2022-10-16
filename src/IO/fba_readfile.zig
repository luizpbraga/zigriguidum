//
const std = @import("std");
const print = std.debug.print;
//
const Allocator = std.mem.Allocator;

pub fn main() !void {
    // stack allocation
    var buff: [100]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buff);
    var allocator = fba.allocator();

    var memory = try allocator.alloc(u8, 50);
    var memory2 = try allocator.alloc(u8, 50);

    defer {
        allocator.free(memory);
        allocator.free(memory2);
    }

    _ = try std.fs.cwd().readFile("./TODO.md", memory);
    _ = try std.fs.cwd().readFile("./TODO.md", memory2);

    std.debug.print("{s}\n{s}\n", .{ memory, memory2 });
}
