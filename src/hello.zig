//
const std = @import("std");
//

test "Hello" {
    try std.io.getStdOut().writer().print("{s}", .{"Hello"});
    try std.io.getStdOut().writer().writeAll("Hello");
    _ = try std.io.getStdOut().writer().write("Hello");
    std.debug.print("{s}", .{"Hello"});
}
