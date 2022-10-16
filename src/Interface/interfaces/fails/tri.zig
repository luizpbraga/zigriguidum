//
const std = @import("std");
const print = std.debug.print;
//
const Tri = struct {
    prt: *anyopaque,
    areaFn: *const fn (ptr: *anyopaque) f64,
};

const Te = struct {
    l: f64,

    fn area(self: Te) f64 {
        return self.l * self.l * @sqrt(3.0) / 4.0;
    }

    fn inter(self: Te) Tri {
        return .{
            .ptr = @ptrCast(*anyopaque, *@TypeOf(self)),
            .areaFn = struct {
                fn area(ptr: *anyopaque) f64 {
                    const s = @ptrCast(*@TypeOf(self), ptr);
                    return s.area;
                }
            }.area,
        };
    }
};

const Ti = struct {
    c1: f64,
    c2: f64,
    h: f64,

    fn area(self: Ti) f64 {
        return self.c1 * self.c2 / 2.0;
    }
};

pub fn main() !void {
    var t = Te{ .l = 12.0 };
    print("{d}", .{t.area()});
    const it = t.inter(){};
    _ = it;
}
