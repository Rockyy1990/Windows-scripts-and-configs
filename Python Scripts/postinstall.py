import subprocess

def run_command(command):
    """Runs a command in the shell and displays the output."""
    try:
        result = subprocess.run(command, check=True, shell=True, text=True, capture_output=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e.stderr}")

def main():
    while True:
        print("\nMenu:")
        print("1. Update Package Source")
        print("2. Upgrade All Packages (Force)")
        print("3. Install yt-dlp")
        print("4. Install ffmpeg")
        print("5. Exit")
        
        choice = input("Enter your choice (1-5): ")

        if choice == "1":
            run_command("winget update")
        elif choice == "2":
            run_command("winget upgrade --all --force")
        elif choice == "3":
            run_command("winget install yt-dlp")
        elif choice == "4":
            run_command("winget install ffmpeg")
        elif choice == "5":
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please select a number between 1 and 5.")

if __name__ == "__main__":
    main()
