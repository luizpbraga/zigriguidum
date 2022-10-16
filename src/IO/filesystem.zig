//
const std = @import("std");
const createFile = std.fs.cwd().createFile;

//
// Ney Dir's name
const dir_name = "TestDir/";

test "Create a directory named TestDir, create a file named testFile.txt is this directory then write and read to it" {
    //
    const files = .{ "testFile1.txt", "testFile2.txt", "testFile3.txt" };
    // creation of a Direcotry
    try std.fs.cwd().makeDir(dir_name);

    // creation of 3 files
    const file1 = try createFile(dir_name ++ files[0], .{ .read = true });
    const file2 = try createFile(dir_name ++ files[1], .{ .read = true });
    const file3 = try createFile(dir_name ++ files[2], .{ .read = true });

    const list_of_files = .{ file1, file2, file3 };

    defer {
        file1.close();
        file2.close();
        file3.close();
    }

    inline for (list_of_files) |file| {
        try file.writeAll("Hello File!");
        // seeking to read the file
        try file.seekTo(0);
    }

    // Read the files
    inline for (list_of_files) |file| {
        var buffer: [25]u8 = undefined;
        const readed_buffer = try file.readAll(&buffer);
        // verifying the content
        try std.testing.expect(std.mem.eql(u8, buffer[0..readed_buffer], "Hello File!"));
    }
}

test "Iterate over Dir" {
    var dir = try std.fs.cwd().openIterableDir(
        dir_name,
        .{},
    );

    defer {
        dir.close();
        std.fs.cwd().deleteTree(dir_name) catch unreachable;
    }

    const files = .{ "testFile4.txt", "testFile5.txt", "testFile6.txt" };

    //
    inline for (files) |file| {
        _ = try dir.dir.createFile(file, .{});
    }

    //
    var file_count: usize = 0;
    var iter = dir.iterate();
    while (try iter.next()) |entry| {
        if (entry.kind == .File) file_count += 1;
    }

    try std.testing.expect(file_count == 6);
}
