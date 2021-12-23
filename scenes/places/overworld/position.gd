extends Position2D

# exports needed variables for ease of use in editor


enum PATH {NONE, LOCKED, UNLOCKED}

export(String) var place := "none"

export(PATH) var up := PATH.NONE
export(NodePath) var u_destination
export(NodePath) var u_path
export(bool) var u_direction

export(PATH) var down := PATH.NONE
export(NodePath) var d_destination
export(NodePath) var d_path
export(bool) var d_direction

export(PATH) var left := PATH.NONE
export(NodePath) var l_destination
export(NodePath) var l_path
export(bool) var l_direction

export(PATH) var right := PATH.NONE
export(NodePath) var r_destination
export(NodePath) var r_path
export(bool) var r_direction
