#!/bin/bash

# Script to automatically update the HTML directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HTML_FILE="$SCRIPT_DIR/index.html"

echo "Scanning for directories with index.html files..."

# Find all directories containing index.html (excluding the root)
PROJECTS=()
for dir in "$SCRIPT_DIR"/*/; do
    if [ -f "$dir/index.html" ]; then
        dirname=$(basename "$dir")
        PROJECTS+=("$dirname")
        echo "Found: $dirname"
    fi
done

# Generate the project list HTML
PROJECT_LIST=""
for project in "${PROJECTS[@]}"; do
    # Capitalize first letter for display
    display_name=$(echo "$project" | sed 's/_/ /g' | sed 's/\b\w/\U&/g')
    PROJECT_LIST+="            <li class=\"project-item\">
                <a href=\"$project/index.html\" class=\"project-link\">$display_name</a>
            </li>
"
done

# Create the updated HTML file
cat > "$HTML_FILE" << EOF
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Directory</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .project-list {
            list-style: none;
            padding: 0;
        }
        .project-item {
            margin: 15px 0;
            padding: 15px;
            background: #f9f9f9;
            border-left: 4px solid #4CAF50;
            border-radius: 4px;
        }
        .project-link {
            text-decoration: none;
            color: #333;
            font-size: 18px;
            font-weight: bold;
        }
        .project-link:hover {
            color: #4CAF50;
        }
        .update-info {
            margin-top: 30px;
            padding: 15px;
            background: #e8f4f8;
            border-radius: 4px;
            font-size: 14px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Project Directory</h1>
        <ul class="project-list">
$PROJECT_LIST        </ul>
        <div class="update-info">
            Last updated: <span id="lastUpdate"></span>
        </div>
    </div>
    
    <script>
        document.getElementById('lastUpdate').textContent = new Date().toLocaleString('zh-TW');
    </script>
</body>
</html>
EOF

echo "Directory updated successfully!"
echo "Found ${#PROJECTS[@]} projects: ${PROJECTS[*]}"