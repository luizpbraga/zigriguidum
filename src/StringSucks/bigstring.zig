//
const std = @import("std");
const print = std.debug.print;
//
pub fn main() !void {
    var s = @embedFile("./js.js").*;
    var i: u8 = 0;

    while (i < s.len) : (i += 1) {
        if (i % 2 == 0) s[i] = 'a';
    }

    print("{s}", .{s});
}
