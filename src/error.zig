const std = @import("std");

const FileOpenError = error{
    AccessDenied,
    FileNotFound,
    OutOfMemory,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try std.testing.expect(err == FileOpenError.OutOfMemory);
}

test "Error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;

    try std.testing.expect(@TypeOf(no_error) == u16);
    try std.testing.expect(no_error == 10);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning error" {
    failingFunction() catch |err| {
        try std.testing.expect(err == error.Oops);
        return;
    };
}

fn failingFunction2() error{Oops}!i32 {
    try failingFunction();
    return 42;
}

test "try in function" {
    const v = failingFunction2() catch |err| {
        try std.testing.expect(err == error.Oops);
        return;
    };
    try std.testing.expect(v == 42); // never reached
}

var problems: u32 = 0;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try std.testing.expect(err == error.Oops);
        try std.testing.expect(problems == 1);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    const x: error{AccessDenied}!void = createFile();

    // error union must be unwrapped with catch
    _ = x catch {};
}

test "error union" {
    const A = error {NotA, NotB};
    const B = error {NotB, NotC};
    const C = A || B;

    try std.testing.expect(C == error{NotA, NotB, NotC});
}
