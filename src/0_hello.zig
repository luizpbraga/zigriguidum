//
const std = @import("std");
//

test "Hello" {
    std.io.getStdOut().writer().print("{s}", .{"Hello"});
}
