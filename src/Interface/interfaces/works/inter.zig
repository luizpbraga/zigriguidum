const std = @import("std");

// o que é anyopaque e alignment ?
// o que faz @prtCast, @alignCast e @call

const Iterator = struct {
    const Self = @This();

    // Fields
    ptr: *anyopaque,
    nextFn: *const fn (*anyopaque) ?u32,

    // Methods
    pub fn init(ptr: anytype) Self {
        // Info of 'ptr'
        const Ptr = @TypeOf(ptr);
        const ptr_info = @typeInfo(Ptr);
        // Checks for Errors
        if (ptr_info != .Pointer) @compileError("ptr must be a pointer");
        if (ptr_info.Pointer.size != .One) @compileError("ptr must be a single item pointer");
        // ?
        const alignment = ptr_info.Pointer.alignment;
        //
        const gen = struct {
            pub fn nextImpl(pointer: *anyopaque) ?u32 {
                const self = @ptrCast(Ptr, @alignCast(alignment, pointer));

                return @call(.{ .modifier = .always_inline }, ptr_info.Pointer.child.next, .{self});
            }
        };

        return .{
            .ptr = ptr,
            .nextFn = gen.nextImpl,
        };
    }

    // Call next
    pub inline fn next(self: Self) ?u32 {
        return self.nextFn(self.ptr);
    }
};

const Range = struct {
    const Self = @This();

    start: u32 = 0,
    end: u32,
    step: u32 = 1,

    pub fn next(self: *Self) ?u32 {
        if (self.start >= self.end) return null;
        const result = self.start;
        self.start += self.step;
        return result;
    }

    pub fn iterator(self: *Self) Iterator {
        return Iterator.init(self);
    }
};

test "Range" {
    var range = Range{ .end = 5 };
    const iter = range.iterator();

    try std.testing.expectEqual(@as(?u32, 0), iter.next());
    try std.testing.expectEqual(@as(?u32, 1), iter.next());
    try std.testing.expectEqual(@as(?u32, 2), iter.next());
    try std.testing.expectEqual(@as(?u32, 3), iter.next());
    try std.testing.expectEqual(@as(?u32, 4), iter.next());
    try std.testing.expectEqual(@as(?u32, null), iter.next());
    try std.testing.expectEqual(@as(?u32, null), iter.next());
}

pub fn main() void {
    var range = Range{ .end = 10 };
    const iter = range.iterator();

    while (iter.next()) |val| {
        std.debug.print("{d}", .{val});
    }
}
