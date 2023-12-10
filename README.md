# raspios-headless-imager

The goal of this project is to enable you to set up a brand new Raspberry Pi without ever having to connect it to a
keyboard, monitor, or ethernet cable, and avoid the following annoying, repetitive tasks:
 * setting up a WiFi network
 * setting up SSH (including passwordless SSH)
 * changing the default username and password

Some people refer to this as a headless setup.

While this is all possible with the Raspberry Pi Imager application, this project provides an automatable command line
environment which can be extended with your own customizations.

You provide your wifi credentials, SSH keys and user details, and this project will create an SD card image for you by
running a single command line script.

## Usage Guide

The following prerequisites are assumed:
 * You are using a Linux based computer
 * You have Docker installed (`sudo apt install docker-ce`)
 * Certain details about your WiFi configuration. See [WiFi configuration details](#wifi-configuration-details) 

To create an image, first create a file called `vars.hcl` and fill in your values. You can copy this file from `vars.template.hcl`.

`user`: The login username of the pi, e.g. `pi`
`password`: The login password of the pi, e.g. `raspberry` used to be the default.

`wifiSsid`: The name of your WiFi network
`wifiPassword`: Your WiFi password.

`sshPublicKey`: Your ssh public key, usually contained in a file called something similar to `~/.ssh/id_ed25519.pub`. It only takes a few seconds to generate an ssh key, there are many guides online.
However you can skip this step by removing the relevant parts of `init-ssh.sh`.

Then, simply run `sudo ./build.sh` and your `.img` file will be created ready for burning to the SD card.

## Which version of RaspiOS is used?

32 Bit RaspiOS Lite Bookworm. This can be changed in `raspios-lite-armhf.pkr.hcl`. Tested on Raspberry Pi 3.

### WiFi configuration details

The wifi configuration is baked into a file on the Pi in `/etc/NetworkManager/system-connections`. If you look at the template
of this file in `init-wifi.sh`, you will see that certain assumptions are made about your wifi settings, such as the
security option being "wpa-psk". In case you find it doesn't work because your wifi settings are different, then
simply set up your wifi network manually using the `raspi-config` tool (or the desktop environment) and when you have a
successful connection, go and look at the file that was created and copy the contents.