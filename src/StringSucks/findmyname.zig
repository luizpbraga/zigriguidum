//
const std = @import("std");
//
test "find name" {
    const my_name = "Luiz";
    const not_my_name = "Carlos Luiz";

    if (std.mem.indexOf(u8, not_my_name, my_name)) |_|
        std.debug.print("I'm in!", .{});
}
