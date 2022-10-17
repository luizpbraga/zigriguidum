const std = @import("std");
const print = std.debug.print;
// hack?
fn times(len: usize) []void {
    var s: []void = undefined;
    s.len = len;
    return s;
}
pub fn main() !void {
    var v: []void = undefined;
    v.len = 100;

    for (times(10)) |_| {
        print("{s}", .{"1"});
    }
}
