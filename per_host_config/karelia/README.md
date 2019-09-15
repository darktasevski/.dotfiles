# openSUSE config

## Sound improvements

For better audio quality change edit pulseaudio daemon.conf (sudo nano /etc/pulse/daemon.conf) and change the default resample-method to copy. Then logout and login and enjoy!

## Install Webstorm

```bash
sudo zypper install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# restart system and after that go to https://flathub.org/apps/details/com.jetbrains.WebStorm download Webstorm and follow instructions
```

## Dropbox


```shell
sudo zypper install dropbox
# Once installed, issue the following command to install the Dropbox daemon.
dropbox start -i
```

By default, Dropbox will automatically start at login. To disable this you can run this command:
```shell
dropbox autostart n
```
To enable autostart again, run:
```shell
dropbox autostart y
```

## NordVPN

```shell
sudo rpm -v --import https://repo.nordvpn.com/gpg/nordvpn_public.asc

sudo zypper install https://repo.nordvpn.com/yum/nordvpn/centos/noarch/Packages/n/nordvpn-release-1.0.0-1.noarch.rpm

sudo zypper addrepo /etc/yum.repos.d/nordvpn.repo

# Install the NordVPN app:

sudo zypper install nordvpn

# Log in to your NordVPN account:

nordvpn login

# Connect to a NordVPN server:

nordvpn connect
```