return {
	cmd = os.getenv('HOME') .. '/oss/zig/zls/zig-out/bin/zls',
	filetypes = { "zig", "zon" },
	root_markers = { "build.zig.zon", "build.zig", ".git" },
}
