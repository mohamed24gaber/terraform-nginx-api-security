resource "aws_key_pair" "nginx_key" {
  key_name   = "nginx-api-security-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZEx8P2l7Eft3EaFabEus3o6zQjz+a6lT6Cs9+KvOWsF5mLCrSiYqRkJ5wslqZ98MnNoshGYFBt5k5DuPQFafPuc7rkbKxA4YbDCXcXat22cUVvc15S9qycd+eD38vAhzsFT9KjUsRyKarBPoZleNoWe3ezxvfw3H6VOooZ20rhHQ0fvzIAtSHM3tMsQ3GbZwF2dIUi9Lu47u2LyNporjhWrb1ew8cIkV5B/E3bIfmAApXzWAM2olp7I1Y1QTR2UD7oezYIcc60CZ7TEeGQTuI4RRgK1t3OSGnO11QtVNd7obZ5HwdzwSUchnLPmLFd7iWP1njCO3uCcmIADktgFs9 nginx-api-security-key"

  lifecycle {
    ignore_changes = [public_key]
  }
}
