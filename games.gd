extends Node

const directory: String = ""
var games: Dictionary

func _enter_tree():
	load_games()

func load_games():
	### WARNING: OS.get_executable_path() isn't reliable on macOS
	var path = directory if directory != "" else OS.get_executable_path().get_base_dir()
	var dirs = DirAccess.get_directories_at(path)
	for d in dirs:
		var fs = DirAccess.get_files_at("/".join([path, d]))
		var exe: String
		var info: String
		for f in fs:
			if f.get_extension() == "exe":
				exe = "/".join([path, d, f])
			elif f.get_extension() == "json":
				info = "/".join([path, d, f])
		var s = FileAccess.get_file_as_string(info)
		games[exe] = JSON.parse_string(s)
