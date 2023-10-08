const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Determine the current Hyperland instance signature
    const his = try std.process.getEnvVarOwned(allocator, "HYPRLAND_INSTANCE_SIGNATURE");
    defer allocator.free(his);

    // Find the IPC socket's path
    const socket_path_components = [_][]const u8{ "/tmp/hypr", his, ".socket2.sock" };
    const socket_path = try std.fs.path.join(allocator, &socket_path_components);
    defer allocator.free(socket_path);

    const stream = try std.net.connectUnixSocket(socket_path);
    const reader = stream.reader();

    // Listen and parse each new line
    while (true) {
        if (reader.readUntilDelimiterAlloc(allocator, '\n', 128)) |line| {
            // Hereby is an example of a line depicting keyboard-layout change:
            // activelayout>>at-translated-set-2-keyboard,Hebrew

            // Filter lines depicting keyboard layout changes
            if (std.mem.startsWith(u8, line, "activelayout>>")) {
                // Parse the lines
                var columns_iterator = std.mem.splitBackwardsScalar(u8, line, ',');
                const layout = columns_iterator.first();

                // Omit updates
                try stdout.print("layout|string|{s}\n", .{layout});
                try stdout.writeByte('\n');
            }
        } else |_| {}
    }
}
