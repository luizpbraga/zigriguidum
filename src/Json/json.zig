//
const std = @import("std");
const print = std.debug.print;
const json = std.json;

//const playload =
//c   \\{
//c   \\  "x": 1,
//c   \\
//c   \\  "y": 2.0,
//c   \\
//c   \\  "z": "ola mundo",
//c   \\
//c   \\  "vetor": {
//c   \\      "r1": -1.0,
//c   \\      "r2": 0.0
//c   \\  },
//c   \\
//c   \\  "vec": [1,1,1]
//c   \\}

const playload = @embedFile("./data.json");
const Config = struct {
    x: u8,
    y: f32,
    z: [9]u8,
    vetor: struct { r1: f32, r2: f32 },
    vec: [3]u8,
};

pub fn main() !void {
    const data = blk: {
        var stream = json.TokenStream.init(playload);
        const data = json.parse(Config, &stream, .{});
        break :blk data catch unreachable;
    };

    print("{d} {d} {s} {d} {d}", .{
        data.x, data.y, data.z, //
        data.vetor.r1, data.vec, //
    });
}
