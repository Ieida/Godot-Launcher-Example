extends Node

var games: Dictionary

func _enter_tree():
	load_games()

func load_games():
	var path = OS.get_executable_path()
	var dir = path.get_base_dir()
	var dirs = DirAccess.get_directories_at(dir)
	for d in dirs:
		var fs = DirAccess.get_files_at("/".join([dir, d]))
		var exe: String
		var info: String
		for f in fs:
			if f.get_extension() == "exe":
				exe = "/".join([dir, d, f])
			elif f.get_extension() == "json":
				info = "/".join([dir, d, f])
		var s = FileAccess.get_file_as_string(info)
		games[exe] = JSON.parse_string(s)
