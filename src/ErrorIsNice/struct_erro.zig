//
const std = @import("std");
const print = std.debug.print;
//

const Bar = struct {
    b: i32 = 10,
};

const Foo = struct { f: anyerror!Bar };

test "struct error" {
    print("{s}", .{""});

    // FUCK!!!!!!!!!!!!!!!!!!!!!!!!!!!
    const f: Foo = Foo{ .f = .{} };
    const b = try f.f;
    _ = b.b;

    const u = try uOrerr();
    _ = u;

    //
    const z = if (uOrerr()) |val| val else |err| {
        _ = err catch {}; // erros cannot be discarted
        unreachable; //
    };
    _ = z;

    const g = uOrerr() catch 2;
    _ = g;
}

fn uOrerr() error{E}!usize {
    return 1;
}
