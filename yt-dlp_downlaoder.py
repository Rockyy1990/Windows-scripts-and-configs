import os
import subprocess

def main_menu():
    print("Welcome to the yt-dlp Video Downloader")
    print("1. Download Video")
    print("2. Update yt-dlp")
    print("3. Exit")
    choice = input("Select an option (1/2/3): ")
    
    return choice

def download_video(video_url):
    try:
        # Construct the yt-dlp command with cookies from Firefox
        command = f'yt-dlp --cookies-from-browser firefox "{video_url}"'
        # Execute the command in a subprocess
        subprocess.run(command, shell=True)
    except Exception as e:
        print(f"An error occurred: {e}")

def update_yt_dlp():
    try:
        # Update yt-dlp
        command = 'yt-dlp -U'
        # Execute the command in a subprocess
        subprocess.run(command, shell=True)
        print("yt-dlp has been updated successfully.")
    except Exception as e:
        print(f"An error occurred during the update: {e}")

def run():
    while True:
        choice = main_menu()
        if choice == '1':
            video_url = input("Enter the video URL: ")
            download_video(video_url)
        elif choice == '2':
            update_yt_dlp()
        elif choice == '3':
            print("Exiting the downloader.")
            break
        else:
            print("Invalid option. Please try again.")

if __name__ == "__main__":
    run()
