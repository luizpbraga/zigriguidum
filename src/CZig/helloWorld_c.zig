//
const std = @import("std");
const c = @cImport(@cInclude("stdio.h"));
//
pub fn main() !void {
    const world = "World!";
    _ = c.printf("Hello %s\n", world);
}
