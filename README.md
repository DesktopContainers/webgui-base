# Base Image for Desktop Applications on lightweight IceWM Window Manager - (desktopcontainers/webgui-base) [x86 + arm]

This container is an alterantive to the desktopcontainers `debian-base` and `alpine-base` containers.

It has a different view on things. First of all, it just exposes NoVNC via HTTP on port 8080.
It's not meant to be used as a baseimage, but rather as a baseline. So fork this repo, add/install the software and put it's execution script into the `/container/scripts/app` file.

Since it's not longer using that many services (e.g.: ssh, vnc, https etc.) it has a much smaller footprint and should be easy to maintain and upgrade
without the dependency hell of using base images etc.

Only 4 optional environment variables for all configuartion options.

- HTTP VNC (port: `8080`, no password)

## Changelogs

* 2024-01-04
    * complete rewrite of `base-debian`
    * removed vnc, https, ssh and x11 protocols
    * keep it simple, just a desktop env accessible from a browser

## Environment variables and defaults

### General

* __ENABLE\_SUDO__
    * set this to _enable_ to allow the user to use sudo
    * default: not set

* __ENABLE\_KIOSK__
    * set this to _enable_ to enable Kiosk mode
        * only run `app` and make sure it will always restart
        * it is advised to not combine with `ENABLE_SUDO` - but it's still possible to use with sudo enabled.
    * default: not set
    * perfect for (fullscreen) software like `rdesktop`, `vncviewer`, Browser etc.

### VNC Settings

* __VNC\_SCREEN\_DEPTH__
    * set the screen depth for the xfvb x-server
    * default: `24`
    * other possible values:
        * 8
        * 16
        * 24

* __VNC\_SCREEN\_RESOLUTION__
    * set this to a specific resolution like '1280x1024' if you want a specific default one
    * default: `1280x1024`
    * depth is configured with `VNC_SCREEN_DEPTH` env
    * other possible values:
        * 640x480
        * 800x600
        * 1024x768
        * 1280x1024
        * 1280x720
        * 1280x800
        * 1280x960
        * 1360x768
        * 1400x1050
        * 1600x1200
        * 1680x1050
        * 1900x1200
        * 1920x1080
        * 1920x1200


### Your custom Application

add all your code used for starting your application/s to `/container/scripts/app`.
