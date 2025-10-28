import subprocess

def run_command(command):
    try:
        subprocess.run(command, check=True, shell=True)
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while running: {command}\nError: {e}")

def main():
    commands = [
        "apt update",
        "apt upgrade -y",
        "apt dist-upgrade -y",
        "apt autoremove -y",
        "apt autoclean -y"
    ]

    for command in commands:
        print(f"Running command: {command}")
        run_command(command)

if __name__ == "__main__":
    main()
