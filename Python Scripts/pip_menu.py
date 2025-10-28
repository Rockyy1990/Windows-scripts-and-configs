import os
import sys

def install_package(package_name):
    os.system(f'pip install {package_name}')

def uninstall_package(package_name):
    os.system(f'pip uninstall -y {package_name}')

def upgrade_package(package_name):
    os.system(f'pip install --upgrade {package_name}')

def list_packages():
    os.system('pip list')

def show_package(package_name):
    os.system(f'pip show {package_name}')

def display_menu():
    print("\n--- Python Package Manager Menu ---")
    print("1. Install a package")
    print("2. Uninstall a package")
    print("3. Upgrade a package")
    print("4. List installed packages")
    print("5. Show package information")
    print("6. Exit")
    
def main():
    while True:
        display_menu()
        choice = input("Choose an option (1-6): ")
        
        if choice == '1':
            package_name = input("Enter the package name to install: ")
            install_package(package_name)
        elif choice == '2':
            package_name = input("Enter the package name to uninstall: ")
            uninstall_package(package_name)
        elif choice == '3':
            package_name = input("Enter the package name to upgrade: ")
            upgrade_package(package_name)
        elif choice == '4':
            list_packages()
        elif choice == '5':
            package_name = input("Enter the package name to show info: ")
            show_package(package_name)
        elif choice == '6':
            print("Exiting...")
            sys.exit()
        else:
            print("Invalid option. Please choose again.")

if __name__ == "__main__":
    main()
