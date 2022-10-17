const std = @import("std");
const print = std.debug.print;

// void or u8
pub fn main() u8 {
    print("{s}", .{""});
    return 0;
}
