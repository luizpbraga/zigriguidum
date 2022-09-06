//
const std = @import("std");
const print = std.debug.print;
//
pub fn main() !void {
    var iter_dir = try std.fs.openIterableDirAbsolute("/home/luizpbraga/Github/fortran4duck/modernfortran/", .{});
    defer iter_dir.close();

    var walk_dir = try iter_dir.walk(std.heap.page_allocator);

    while (try walk_dir.next()) |entry| {
        switch (entry.kind) {
            .File => print("File: {s}\n", .{entry.basename}),
            .Directory => print("Dir: {s}\n", .{entry.basename}),
            else => {},
        }
    }
}
