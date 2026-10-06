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

cp templates/attendance_checker.py "attendance_tracker_$project_name/attendance_checker.py"
cp templates/config.json "attendance_tracker_$project_name/Helpers/config.json"
echo "Template files copied."

read -p "Choose roster option - (A) Copy from template or (B) Generate fresh: " roster_choice

if [ "$roster_choice" = "A" ] || [ "$roster_choice" = "a" ]; then
    echo "You chose to copy from template."
elif [ "$roster_choice" = "B" ] || [ "$roster_choice" = "b" ]; then
    echo "You chose to generate fresh."
else
    echo "Invalid choice."
fi
