const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello, world!\n", .{});

    const arr = [_]u8{1, 2, 3, 4, 5, 5};

    const len = arr.len;

    std.debug.print("Length: {}\n", .{len});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
