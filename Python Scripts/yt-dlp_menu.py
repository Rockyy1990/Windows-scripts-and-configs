#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
yt_dlp_menu.py – Compact Windows menu for yt‑dlp.

Features
--------
1️⃣ Video download  yt‑dlp --cookies-from-browser firefox <url>
2️⃣ Audio‑only download yt‑dlp --cookies-from-browser firefox -f bestaudio -x --audio-format mp3 <url>
3️⃣ Update yt‑dlp  yt‑dlp -U
"""

import subprocess
import sys
from pathlib import Path

# ----------------------------------------------------------------------
# Optional dependency: colorama (for colored console output)
# ----------------------------------------------------------------------
try:
    from colorama import init, Fore, Style
except ImportError:                                   # pragma: no cover
    subprocess.check_call([sys.executable, "-m", "pip", "install", "colorama"])
    from colorama import init, Fore, Style

init(autoreset=True)

# Color palette – closest to orange in the default Windows console
ORANGE = Fore.LIGHTRED_EX
SUCCESS = Fore.GREEN
WARN = Fore.YELLOW
ERROR = Fore.RED

# ----------------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------------
def run(command: list[str]) -> None:
    """Run a command, streaming stdout/stderr. Prints a short error on failure."""
    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError as exc:
        print(f"{ERROR}Command failed (exit {exc.returncode})")


def prompt_url() -> str:
    """Ask the user for a URL; returns an empty string if none entered."""
    return input("Enter video URL: ").strip()


def video():
    url = prompt_url()
    if not url:
        print(f"{WARN}No URL – aborting.")
        return
    print(f"{ORANGE}Downloading video…")
    run(["yt-dlp", "--cookies-from-browser", "firefox", url])


def audio():
    url = prompt_url()
    if not url:
        print(f"{WARN}No URL – aborting.")
        return
    print(f"{ORANGE}Downloading audio only…")
    run([
        "yt-dlp",
        "--cookies-from-browser", "firefox",
        "-f", "bestaudio",
        "-x", "--audio-format", "aac",
        url,
    ])


def update():
    print(f"{ORANGE}Updating yt‑dlp…")
    run(["yt-dlp", "-U"])


# ----------------------------------------------------------------------
# Main menu loop
# ----------------------------------------------------------------------
def main() -> None:
    # Ensure relative paths work when the script is launched from elsewhere
    try:
        os.chdir(Path(__file__).parent)
    except Exception:  # pragma: no cover
        pass

    menu = f"""
{ORANGE}=== yt‑dlp Menu ==={Style.RESET_ALL}
1) Video download
2) Audio‑only download
3) Update yt‑dlp
0) Exit
"""

    actions = {
        "1": video,
        "2": audio,
        "3": update,
        "0": lambda: print(f"{SUCCESS}Good‑bye!"),
    }

    while True:
        print(menu)
        choice = input("Select an option: ").strip()
        if choice in actions:
            if choice == "0":
                actions[choice]()
                break
            actions[choice]()
        else:
            print(f"{WARN}Invalid choice – try again.")


if __name__ == "__main__":
    main()
