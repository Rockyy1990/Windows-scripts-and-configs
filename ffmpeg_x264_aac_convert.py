import subprocess

def convert_to_x264(input_file, output_file):
    # Construct the ffmpeg command with arguments
    ffmpeg_command = [
        'ffmpeg',
        '-i', input_file,
        '-vcodec', 'libx264',
        '-vb', '2300k',
        '-tune', 'film',
        '-tune', 'fastdecode',
        '-preset', 'medium',
        '-acodec', 'aac',
        '-ab', '224k',
        '-ac', '2',
        output_file
    ]

    # Execute the ffmpeg command
    subprocess.run(ffmpeg_command)

def main():
    print("FFMPEG x264 aac Video Converte!")
    
    # Get input file from user
    input_file = input("Please enter the path to the input file: ")
    
    # Get output file from user
    output_file = input("Please enter the path for the output file (including extension): ")

    # Call the conversion function
    convert_to_x264(input_file, output_file)
    
    print("Conversion completed!")

if __name__ == "__main__":
    main()
