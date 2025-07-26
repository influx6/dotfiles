server  {
	enabled = true
	bootstrap_expect = 1
}

plugin "docker" {
	config {
		allow_privileged = true
		allow_caps = ["ALL"]
	}
}
