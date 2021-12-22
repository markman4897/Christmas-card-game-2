extends Position2D


export(String) var place := "none"

export(bool) var up := false
export(NodePath) var u_destination
export(NodePath) var u_path
export(bool) var u_direction

export(bool) var down := false
export(NodePath) var d_destination
export(NodePath) var d_path
export(bool) var d_direction

export(bool) var left := false
export(NodePath) var l_destination
export(NodePath) var l_path
export(bool) var l_direction

export(bool) var right := false
export(NodePath) var r_destination
export(NodePath) var r_path
export(bool) var r_direction
