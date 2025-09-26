# Signal-Desktop AppImage

Latest stable AppImage build of Signal Desktop: https://github.com/signalapp/Signal-Desktop

There is no official Signal-Desktop rpm and for security reasons I try to avoid community built snaps or Flatpaks.

## Wayland Support

> Found in this comment: https://github.com/signalapp/Signal-Desktop/issues/3411#issuecomment-1763576244

`./Signal-7.29.0.AppImage --no-sandbox %U --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WaylandWindowDecorations`

Use "Gear Lever" and set the command line arguments.
