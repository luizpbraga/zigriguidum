const std = @import("std");

const Triangle = struct {
    impl: *anyopaque,
    areaFn: *const fn (*anyopaque) f64,

    pub inline fn area(triangle: *const Triangle) f64 {
        return triangle.areaFn(triangle.impl);
    }
};

const T_equilateral = struct {
    const Self = @This();
    l: f64,

    fn areaFn(ptr: *anyopaque) f64 {
        var self = @ptrCast(*Self, @alignCast(@alignOf(Self), ptr));
        return self.l * self.l * @sqrt(3.0) / 4.0;
    }

    fn triangle(self: *Self) Triangle {
        return .{
            .impl = @ptrCast(*anyopaque, self),
            .areaFn = areaFn,
        };
    }

    fn area(self: *Self) f64 {
        return self.triangle().area();
    }
};

const T_rectangle = struct {
    const Self = @This();
    c1: f64,
    c2: f64,
    h: f64,

    fn areaFn(ptr: *anyopaque) f64 {
        var self = @ptrCast(*Self, @alignCast(@alignOf(Self), ptr));
        return self.c1 * self.c2 / 2.0;
    }

    fn triangle(self: *Self) Triangle {
        return .{
            .impl = @ptrCast(*anyopaque, self),
            .areaFn = areaFn,
        };
    }

    fn area(self: *Self) f64 {
        return self.triangle().area();
    }
};

fn areaTri(t: Triangle) f64 {
    return t.area();
}

pub fn main() void {
    var te = T_equilateral{ .l = 12.0 };
    var tr = T_rectangle{ .c1 = 8.0, .c2 = 15.0, .h = 17.0 };

    var t = te.triangle();
    std.debug.print("{d} {d}\n", .{ areaTri(t), te.area() });
    t = tr.triangle();
    std.debug.print("{d} {d}\n", .{ areaTri(t), tr.area() });
}
