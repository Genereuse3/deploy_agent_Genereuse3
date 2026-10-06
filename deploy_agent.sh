if ! command -v python3 &> /dev/null; then echo "Error: python3 is not installed."
        exit 1
fi

if ! command -v zip &> /dev/null; then echo "Error: zip is not installed."
        exit 1
fi

read -p "Enter a project name: " project_name

if [ -d "attendance_tracker_$project_name" ]; then
    read -p "Directory already exists. Overwrite? (y/n): " answer
    if [ "$answer" = "y" ]; then
        echo "Overwriting..."
    else
        echo "Aborting."
        exit 1
    fi
fi

mkdir -p "attendance_tracker_$project_name/Helpers"
mkdir -p "attendance_tracker_$project_name/reports"
echo "Directory structure created."
