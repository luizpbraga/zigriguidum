const std = @import("std");

const Test = struct {
    name: []const u8,
    num: u8,
};

const tests = [_]Test{
    .{ .name = "hello", .num = 0 },
    .{ .name = "block", .num = 1 },
    .{ .name = "casting", .num = 2 },
    .{ .name = "cmd", .num = 3 },
    .{ .name = "cmdline", .num = 4 },
    .{ .name = "fileinfo", .num = 5 },
    .{ .name = "filesystem", .num = 6 },
    .{ .name = "findmyname", .num = 7 },
    .{ .name = "implicitystructfile", .num = 8 },
    .{ .name = "optype", .num = 9 },
    .{ .name = "patterns", .num = 10 },
    .{ .name = "pointerslices", .num = 11 },
    .{ .name = "readafile", .num = 12 },
    .{ .name = "readafile2", .num = 13 },
    .{ .name = "readdir", .num = 14 },
    .{ .name = "readfloat", .num = 15 },
    .{ .name = "readlinebyline", .num = 16 },
    .{ .name = "safe", .num = 17 },
    .{ .name = "split", .num = 18 },
    .{ .name = "stringfunc", .num = 19 },
    .{ .name = "struct", .num = 20 },
    .{ .name = "structerro", .num = 21 },
    .{ .name = "struct_module", .num = 22 },
    .{ .name = "types", .num = 23 },
    .{ .name = "while", .num = 24 },
};

// TODO: crieate a build.zig file
pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addTestSource("src"); //;addExecutable("zigriguidum", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}
