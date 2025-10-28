import os

def update_windows():
    os.system('dism /Online /Cleanup-Image /RestoreHealth')
    print("Update completed.")

def cleanup_windows():
    os.system('dism /Online /Cleanup-Image /StartComponentCleanup')
    print("Cleanup completed.")

def troubleshoot_windows():
    os.system('dism /Online /Cleanup-Image /CheckHealth')
    print("Troubleshooting completed.")

def main():
    while True:
        print("\n### DISM Menu ###")
        print("1. Update Windows")
        print("2. Cleanup Windows")
        print("3. Troubleshoot Windows")
        print("4. Exit")
        
        choice = input("Select an option (1-4): ")
        
        if choice == '1':
            update_windows()
        elif choice == '2':
            cleanup_windows()
        elif choice == '3':
            troubleshoot_windows()
        elif choice == '4':
            print("Exiting...")
            break
        else:
            print("Invalid option, please try again.")

if __name__ == "__main__":
    main()
