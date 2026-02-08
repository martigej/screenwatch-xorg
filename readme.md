# screenwatch-xorg

Turn off the screen **only when the image is static**, while **keeping audio playing**.

This project solves a very specific Linux/Xorg problem:

- Watching YouTube or videos
- If the video is visible → the screen must stay on
- If the browser is minimized (audio only) → the screen should turn off
- Audio must continue playing

This avoids DPMS, screen lock, and screensaver behavior that usually pauses video or audio.

---

## How it works

- Takes a small screenshot of a fixed region in the center of the screen
- Compares image hashes between executions
- If the image does not change for a defined time → the screen is blanked
- If the image changes → nothing happens

No daemon.  
No background service.  
No system installation.

---

## Requirements

- Xorg (not Wayland)
- `scrot`
- `xrandr`
- `cron`

Install dependency:

```bash
sudo apt install scrot
