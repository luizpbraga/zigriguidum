//
const std = @import("std");
const print = std.debug.print;
const Vec3 = @Vector(3, f64);
const math = std.math;
//
const SOLARMASS: f64 = 4.0 * math.pi * math.pi;
const DAYSPERYEAR: f64 = 365.24;

const Body = struct {
    r: Vec3,
    v: Vec3,
    m: f64,
    fn offSetMomentum(this: *Body, p: Vec3) void {
        this.v = -p / @splat(3, SOLARMASS);
    }
};

fn newSystem(sys: []Body) ![]Body {
    var n: []Body = try std.heap.page_allocator.alloc(Body, sys.len);
    var _p: Vec3 = .{ 0, 0, 0 };
    for (sys) |_, i| n[i] = sys[i];
    for (n) |b| _p += b.v * @splat(3, b.m);
    n[0].offSetMomentum(_p);
    return n;
}

fn energy(sys: []Body) f64 {
    var e: f64 = 0.0;
    for (sys) |b, i| {
        var j = i + 1;
        e += 0.5 * b.m * @reduce(.Add, b.v * b.v);
        while (j < sys.len) : (j += 1) {
            const b2 = sys[j];
            const d = b.r - b2.r;
            const dist = @sqrt(@reduce(.Add, d * d));
            e -= (b.m * b2.m) / dist;
        }
    }
    return e;
}

fn advance(sys: []Body, dt: f64) void {
    for (sys) |*b, i| {
        var v = b.v;
        var j = i + 1;
        while (j < sys.len) : (j += 1) {
            var b2 = sys[j];
            var d = b.r - b2.r;
            const d_sqr = @reduce(.Add, d * d);
            const dist = @sqrt(d_sqr);
            const mag = dt / (d_sqr * dist);
            v -= d * @splat(3, b2.m * mag);
            b2.v += d * @splat(3, b.m * mag);
        }
        b.v = v;
        b.r += @splat(3, dt) * v;
    }
}

pub fn main() !void {
    var sys = try newSystem(&system);
    print("{d}\n", .{energy(sys)});
    for ([_]u0{0} ** 99) |_| advance(sys, 0.01);
    print("{d}\n", .{energy(sys)});
}

var system = [_]Body{
    // Sum
    .{
        .r = .{ 0, 0, 0 },
        .v = .{ 0, 0, 0 },
        .m = SOLARMASS,
    },
    // Jupter
    .{
        .r = .{ 4.84143144246472090, -1.16032004402742839, -0.103622044471123109 },
        .v = .{ 1.66007664274403694e-03 * DAYSPERYEAR, 7.69901118419740425e-03 * DAYSPERYEAR, -6.90460016972063023e-05 * DAYSPERYEAR },
        .m = 9.54791938424326609e-04 * SOLARMASS,
    },
    // Saturn
    .{
        .r = .{ 8.34336671824457987, 4.12479856412430479, -0.403523417114321381 },
        .v = .{ -2.76742510726862411e-03 * DAYSPERYEAR, 4.99852801234917238e-03 * DAYSPERYEAR, 2.30417297573763929e-05 * DAYSPERYEAR },
        .m = 2.85885980666130812e-04 * SOLARMASS,
    },
    // Uranus
    .{
        .r = .{ 12.8943695621391310, -15.1111514016986312, -0.223307578892655734 },
        .v = .{ 2.96460137564761618e-03 * DAYSPERYEAR, 2.37847173959480950e-03 * DAYSPERYEAR, -2.96589568540237556e-05 * DAYSPERYEAR },
        .m = 4.36624404335156298e-05 * SOLARMASS,
    },
    // Neptune
    .{
        .r = .{ 15.3796971148509165, -25.9193146099879641, 0.179258772950371181 },
        .v = .{ 2.68067772490389322e-03 * DAYSPERYEAR, 1.62824170038242295e-03 * DAYSPERYEAR, -9.51592254519715870e-05 * DAYSPERYEAR },
        .m = 5.15138902046611451e-05 * SOLARMASS,
    },
};
