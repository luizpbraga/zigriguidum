//
const std = @import("std");
const print = std.debug.print;
//
fn range(len: usize) []void {
    var s: []void = undefined;
    s.len = len;
    return s;
}
pub fn main() !void {
    var v: []void = undefined;
    v.len = 100;

    for (range(10)) |_| {
        print("{s}", .{"1"});
    }
}
