variable "password" {
  type      = string
  sensitive = true
}

variable "user" {
  type      = string
  sensitive = true
}

variable "wifiPassword" {
  type      = string
  sensitive = true
}

variable "wifiSsid" {
  type      = string
  sensitive = true
}

variable "sshPublicKey" {
  type = string
}

source "arm" "autogenerated_1" {
  file_checksum_type    = "sha256"
  file_checksum_url     = "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2023-12-06/2023-12-05-raspios-bookworm-armhf-lite.img.xz.sha256"
  file_target_extension = "xz"
  file_unarchive_cmd    = ["unxz", "$ARCHIVE_PATH"]
  file_urls             = [
    "https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2023-12-06/2023-12-05-raspios-bookworm-armhf-lite.img.xz"
  ]
  image_build_method = "reuse"
  image_chroot_env   = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  image_partitions {
    filesystem   = "vfat"
    mountpoint   = "/boot"
    name         = "boot"
    size         = "537M"
    start_sector = "8192"
    type         = "c"
  }
  image_partitions {
    filesystem   = "ext4"
    mountpoint   = "/"
    name         = "root"
    size         = "0"
    start_sector = "1056768"
    type         = "83"
  }
  image_path                   = "raspios-armhf.img"
  image_size                   = "2590M"
  image_type                   = "dos"
  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.autogenerated_1"]

  provisioner "shell" {
    script           = "init-ssh.sh"
    environment_vars = [
      "USER=${var.user}",
      "PASSWORD=${var.password}",
      "KEY=${var.sshPublicKey}"
    ]
  }

  provisioner "shell" {
    script           = "init-wifi.sh"
    environment_vars = [
      "PASSWORD=${var.wifiPassword}",
      "SSID=${var.wifiSsid}",
    ]
  }

}