const expect = @import("std").testing.expect;
//
test "while \n" {
    var i: usize = 0;
    var j: usize = 100;
    //
    var m: [50]usize = undefined;

    while (i < 50) : ({
        i += 1;
        j = i + 1;
    }) {
        m[i] = j;
    }

    try expect(m[i - 1] == j - 1);
    // for (m) |el, in|
    //     @import("std").debug.print("{d} {d}\n", .{ in, el });
}
