if ! command -v python3 &> /dev/null; then echo "Error: python3 is not installed."
        exit 1
fi

if ! command -v zip &> /dev/null; then echo "Error: zip is not installed."
        exit 1
fi

read -p "Enter a project name: " project_name
