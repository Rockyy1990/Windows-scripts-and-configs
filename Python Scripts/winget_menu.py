#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
winget_menu.py – Compact orange‑themed Windows menu.

Features
--------
1️⃣ Update the winget client itself
2️⃣ Upgrade all packages (force reinstall)
3️⃣ Search the catalog
4️⃣ Install a custom program
0️⃣ Exit
"""

import subprocess
import sys
from pathlib import Path

# --------------------------------------------------------------
# Optional dependency: colorama (for colored console output)
# --------------------------------------------------------------
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

# --------------------------------------------------------------
# Helper utilities
# --------------------------------------------------------------
def run(cmd: list[str]) -> None:
    """Execute a command, streaming its output. Prints a short error on failure."""
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as exc:
        print(f"{ERROR}Command failed (exit {exc.returncode})")


def prompt(msg: str) -> str:
    """Read a line from stdin and strip whitespace."""
    return input(msg).strip()


def update_winget():
    print(f"{ORANGE}Updating winget client…")
    run(["winget", "upgrade", "--id", "Microsoft.Winget.Source"])


def upgrade_all():
    confirm = prompt("Force reinstall all packages? (y/N): ").lower()
    if confirm != "y":
        print(f"{WARN}Operation cancelled.")
        return
    print(f"{ORANGE}Upgrading all packages with --force …")
    run(["winget", "upgrade", "--all", "--force"])


def search_catalog():
    term = prompt("Search term (leave empty to cancel): ")
    if not term:
        print(f"{WARN}No term – aborting.")
        return
    print(f"{ORANGE}Searching for \"{term}\" …")
    run(["winget", "search", term])


def install_program():
    prog = prompt("Program ID or name to install (leave empty to cancel): ")
    if not prog:
        print(f"{WARN}No program – aborting.")
        return
    print(f"{ORANGE}Installing {prog} …")
    run(["winget", "install", prog])


# --------------------------------------------------------------
# Main menu loop
# --------------------------------------------------------------
def main() -> None:
    # Make relative paths work when script is launched from another folder
    try:
        import os
        os.chdir(Path(__file__).parent)
    except Exception:  # pragma: no cover
        pass

    menu = f"""
{ORANGE}=== winget Menu ==={Style.RESET_ALL}
1) Update winget client
2) Upgrade all system packages (force)
3) Search the catalog
4) Install a custom program
0) Exit
"""

    actions = {
        "1": update_winget,
        "2": upgrade_all,
        "3": search_catalog,
        "4": install_program,
        "0": lambda: print(f"{SUCCESS}Good‑bye!"),
    }

    while True:
        print(menu)
        choice = prompt("Select an option: ")
        if choice in actions:
            if choice == "0":
                actions[choice]()
                break
            actions[choice]()
        else:
            print(f"{WARN}Invalid choice – try again.")


if __name__ == "__main__":
    main()
