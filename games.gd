extends Node

var games: Array

func _enter_tree():
	load_games()

func load_games():
	### WARNING: OS.get_executable_path() isn't reliable on macOS
	### Get path to launcher executable
	var path = OS.get_executable_path().get_base_dir()
	### Load all of the games
	var dirs = DirAccess.get_directories_at(path)
	for d in dirs:
		var full_path = "/".join([path, d])
		var file_paths = DirAccess.get_files_at(full_path)
		### Load game
		var info = {}
		for f in file_paths:
			var file_path = "/".join([full_path, f])
			if f.get_extension() == "exe":
				info[&"exe_path"] = file_path
			elif f.get_extension() == "json":
				var s = FileAccess.get_file_as_string(file_path)
				var p = JSON.parse_string(s)
				if not p: printerr("Failed parsing %s" % file_path)
				else:
					info[&"info_path"] = file_path
					info.merge(p)
		### Save loaded game
		games.append(info)
