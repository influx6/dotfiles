server  {
	enabled = true
	boostrap_expect = 1
}

plugin "docker" {
	config {
		allow_privileged = true
		allow_caps = ["ALL"]
	}
}
