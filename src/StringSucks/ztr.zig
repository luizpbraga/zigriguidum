//
const std = @import("std");
const print = std.debug.print;
//
const str = []const u8;

fn foo(s: str, n: usize) !str {
    var w = try std.heap.page_allocator.alloc(u8, s.len * n);
    return w;
}
pub fn main() !void {
    var w: []const u8 = try foo("ola", 2);
    _ = w;
}
