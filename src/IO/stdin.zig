//
const std = @import("std");
const print = std.debug.print;
//
//
const Data = struct {
    int: i32,
    float: f64,
};

pub fn main() !void {
    var buffer = try std.heap.page_allocator.alloc(u8, 5);
    _ = try std.io.getStdIn().reader().read(buffer);
    print("{s}", .{buffer});
}

test "file" {
    const v = 1;
    const s = 1;
    _ = s + v;
}
