//
const std = @import("std");
const print = std.debug.print;
const allocator = std.heap.page_allocator;
const eql = std.mem.eql;

const Status = enum(u8) { connected, disconnected };

const Display = struct {
    const This = @This();

    name: ?[]const u8 = null,
    path: ?[]const u8 = null,
    status: ?Status = null,
    argv: []const []const u8 = &.{ "xrandr", "--auto" },
    beeingUsed: bool = false,

    fn updateStatus(this: *This) anyerror!void {
        var status_buf: [12]u8 = undefined;

        if (this.name == null) return error.DisplayWithNullName;
        if (this.path == null) return error.DisplayWithNullPath;

        _ = try std.fs.cwd().readFile(this.path.?, &status_buf);

        switch (status_buf[0]) {
            'c' => this.status = .connected,
            'd' => this.status = .disconnected,
            else => return error.EnableToGetStatus,
        }
    }
};

fn useDisplay(display: *Display) anyerror!void {
    if (display.status.? == .connected) {
        const result = try std.ChildProcess.exec(.{ .argv = display.argv, .allocator = allocator });
        try std.io.getStdOut().writer().print("{s}\n", .{result.stdout});
        display.beeingUsed = true;
    } else return error.DisplayNotConnected;
}

pub fn main() !void {
    // paths to status file
    const path_eDP1 = "/sys/class/drm/card0-eDP-1/status";
    const path_HDMI1 = "/sys/class/drm/card0-HDMI-A-1/status";
    const argv_eDP1 = &[_][]const u8{ "echo", "xrandr", "--output", "eDP1", "--mode", "1920x1080" };
    const argv_HDMI1 = &[_][]const u8{ "echo", "xrandr", "--output", "HDMI1", "--mode", "1920x1080" };

    // Display declaration
    var note = Display{ .name = "eDP1", .path = path_eDP1, .argv = argv_eDP1 };
    var hdmi1 = Display{ .name = "HDMI1", .path = path_HDMI1, .argv = argv_HDMI1 };
    var dual = Display{};

    // First Status Update
    try hdmi1.updateStatus();
    try note.updateStatustatus();

    std.debug.print("{any}\n{any}", .{ note.status, hdmi1.status });

    // TODO:: implement an command line app to configure display options
    // ! `arg` should have only 2 alements. The second one is the display witch will be used;
    const arg = try std.process.argsAlloc(allocator);
    if (arg.len == 2)
        if (eql(u8, arg[1], note.name.?)) {
            try useDisplay(&note);
        } else if (eql(u8, arg[1], hdmi1.name.?)) {
            try useDisplay(&hdmi1);
        } else try useDisplay(&dual);

    const read_config_file = false;
    // TODO: implement a confi file
    if (read_config_file) {}

    // update
    try useDisplay(&hdmi1);

    //var current =
}
