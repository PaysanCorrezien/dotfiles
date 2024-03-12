## Enable graphical interface on the WSL CLIENT from windows

### Windows Part

```powershell
choco install vcxsrv pulseaudio
```

We need to make a way to start the X server and the pulseaudio server at the same time.
Working script in this folder.
We need to set firewall rules to allow WSL to access the X server (Script in this folder).

### Linux Part

Put the script launch_gui in ~/

#### Graphical Interface : XFCE

<!-- TODO: i3 optimized -->

```bash
sudo apt install xfce4 xfce4-goodies
```

#### Set the DISPLAY variable

```bash
# Set the DISPLAY variable to the IP of the Windows host
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
# Force XFCE and other applications to use X11 instead of Wayland
export GDK_BACKEND=x11
```

**It only work if you didnt hardcode something else in /etv/resolv.conf**

## REFERENCES

[Shogan.co.uk](https://www.shogan.co.uk/how-tos/wsl2-gui-x-server-using-vcxsrv/)
