const std = @import("std");
const stdin = std.io.getStdIn();
const stdout = std.io.getStdOut();

pub fn main() !void {
    var buff: [100]u8 = undefined;
    const size = try stdin.read(&buff);
    const line = std.mem.trim(u8, buff[0..size], "\r\n");

    std.debug.print("{s}, {}\n", .{ line, size });
    try stdout.writeAll("hello world!");
}
