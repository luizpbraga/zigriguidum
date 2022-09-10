//
const std = @import("std");
const print = std.debug.print;
//
pub fn main() !void {
    const str = "1.0 0.0 0.0 -1.0";
    var number: [4]f32 = undefined;
    var i: usize = 0;
    var iter = std.mem.split(u8, str, " ");

    while (iter.next()) |str_number| : (i += 1) {
        number[i] = try std.fmt.parseFloat(f32, str_number);
    }
    print("{any}", .{number});

    const str_matrix =
        \\1.0 0.0
        \\0.0 1.0
    ;

    readMatrix(str_matrix);
}

fn readMatrix(str: []const u8) void {
    var lines = std.mem.split(u8, str, "\n");

    while (lines.next()) |line| {
        var numbers = std.mem.split(u8, line, " ");
        while (numbers.next()) |number| {
            print("{s}\n", .{number});
        }
    }
}
