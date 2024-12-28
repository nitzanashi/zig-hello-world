const std = @import("std");
const expect = std.testing.expect;

fn checkEqual(a: anytype, b: anytype) !void {
    if (a != b) {
        std.debug.print("Mismatch: expected {}, got {}\n", .{a, b});
        return error.TestFailed;
    }
}


test "always pass" {
    try expect(true);
}

test "If conditions" {
    const always_true = true;

    var x: u16 = 0;

    if (always_true) {
        x = 1;
    } else {
        x = 2;
    }

    try expect(x == 1);

    x += if (always_true) 5 else 10;

    try expect(x == 6);
}

test "While statements" {
    var x: u16 = 0;

    while (x < 5) {
        x += 1;
    }

    try checkEqual(5, x);
}


test "For loops" {
    const str = [_]u8{'a', 'b', 'c', 'd', 'e'};

    for (str, 0..) |character, index| {
        std.debug.print("Character: {}\n", .{character});
        _ = index; // unused but require assignment
    }

    for (str, &str) |character, _| {
        std.debug.print("Character: {}\n", .{character});
    }

    for (str) |character| {
        _ = character; // unused but require assignment
    }

    for (str) |_| {}
}
