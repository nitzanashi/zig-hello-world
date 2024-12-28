const std = @import("std");

// defer is used to execute statemenet upon exiting the current block
// see https://zig.guide/language-basics/defer
// Defer is useful to ensure that resources are cleaned up when they are no longer needed.
// Instead of needing to remember to manually free up the resource, you can add a defer statement right next to the statement that allocates the resource.

test "defer" {
    var x: u16 = 5;
    {
        defer x += 2;
        try std.testing.expect(x == 5);
    }
    try std.testing.expect(x == 7);
}

// defer is executed in reverse order
test "defer multiple" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
        try std.testing.expect(x == 5);
    }
    try std.testing.expect(x == 4.5);
}
