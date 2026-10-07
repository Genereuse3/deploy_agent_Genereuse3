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
    read -p "How many students to copy? " num_students
    lines_needed=$((num_students + 1))
    head -n "$lines_needed" templates/assets.csv > "attendance_tracker_$project_name/Helpers/assets.csv"
    echo "Copied $num_students students from template."

elif [ "$roster_choice" = "B" ] || [ "$roster_choice" = "b" ]; then
    names=("Zara Khan" "Liam Chen" "Maya Patel" "Noah Garcia" "Priya Sharma" "Omar Haddad" "Lena Novak" "Kofi Boateng" "Mei Tanaka" "Sofia Rossi")
    emails=("zara@example.com" "liam@example.com" "maya@example.com" "noah@example.com" "priya@example.com" "omar@example.com" "lena@example.com" "kofi@example.com" "mei@example.com" "sofia@example.com")

    read -p "How many students to generate? " num_students
    last_index=$((num_students - 1))

    echo "Email,Names,Attendance Count,Absence Count" > "attendance_tracker_$project_name/Helpers/assets.csv"
    for i in $(seq 0 "$last_index"); do
        echo "${emails[$i]},${names[$i]},0,0" >> "attendance_tracker_$project_name/Helpers/assets.csv"
    done

    sed -i 's/"total_sessions": 5/"total_sessions": 1/' "attendance_tracker_$project_name/Helpers/config.json"
    echo "Generated $num_students fresh students. total_sessions set to 1."

else
    echo "Invalid choice."
fi

chmod +x "attendance_tracker_$project_name/attendance_checker.py"
chmod 600 "attendance_tracker_$project_name/Helpers/config.json"
echo "Permissions set: attendance_checker.py is executable, config.json is owner read/write only."
