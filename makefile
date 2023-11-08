.phony:
	install
install:
	bun install && bun run tauri build
