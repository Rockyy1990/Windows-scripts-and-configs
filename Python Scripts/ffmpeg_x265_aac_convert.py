import subprocess

def convert_to_x265(input_file, output_file):
    # Construct the ffmpeg command with arguments
    ffmpeg_command = [
        'ffmpeg',
        '-i', input_file,
        '-vcodec', 'libx265',  # H.265 video codec
        '-vb', '2300k',        # Video bitrate
        '-tune', 'film',
        '-tune', 'fastdecode',
        '-preset', 'medium',
        '-acodec', 'aac',      # AAC audio codec
        '-ab', '224k',        # Audio bitrate
        '-ac', '2',           # Number of audio channels
        output_file
    ]

    # Execute the ffmpeg command
    result = subprocess.run(ffmpeg_command, capture_output=True, text=True)

    # Check for errors
    if result.returncode != 0:
        print(f"Error occurred: {result.stderr}")
    else:
        print("Conversion successful!")

def main():
    print("FFMPEG x265 aac Video Converter!")
    
    # Get input file from user
    input_file = input("Please enter the path to the input file: ")
    
    # Get output file from user
    output_file = input("Please enter the path for the output file (including extension): ")

    # Call the conversion function
    convert_to_x265(input_file, output_file)
    
    print("Conversion completed!")

if __name__ == "__main__":
    main()
