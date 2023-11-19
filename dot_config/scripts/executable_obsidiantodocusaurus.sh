#!/bin/bash

# Debug flag
debug=true

# Function to output debug messages
debug_echo() {
    if [ "$debug" = true ]; then
        echo "DEBUG: $1"
    fi
}
# Hardcoded paths
# TODO: replace with a cmd.exe whoami + an arg for windows user folder dir /Documents/Obsidian ..
image_source_path="/mnt/c/Users/dylan/Documents/Obsidian Vault/Zettelkasten/Files/"
blog_destination_path="/mnt/c/Users/dylan/Documents/Projet/Work/Projet/blog2023/blog/"
docs_destination_path="/mnt/c/Users/dylan/Documents/Projet/Work/Projet/blog2023/docs/KnowledgeBase/"
remote_image_path="/mnt/c/Users/dylan/Documents/Projet/Work/Projet/blog2023/static/img/"  # This path ends with 'assets/'

debug_echo "Paths set. Image source: $image_source_path, Blog dest: $blog_destination_path, Docs dest: $docs_destination_path, Remote image path: $remote_image_path"

# Function to extract image names and update links
update_image_links() {
    local file=$1
    local image_name
    local new_image_name

    grep -oP '\!\[\[\K.*?(?=\]\])' "$file" | while read -r image_name; do
        debug_echo "Processing image: $image_name"

        # Replace spaces with dashes in the image name
        new_image_name=$(echo "$image_name" | sed 's/ /-/g')

        # Copy image from source to remote path with updated image name
        cp "${image_source_path}/${image_name}" "${remote_image_path}/${new_image_name}"
        debug_echo "Copied $image_name to $remote_image_path/$new_image_name"

        # Build new link with correct path for Docusaurus and updated image name
        new_link=".././static/img/${new_image_name}"
        debug_echo "New link: $new_link"

        # Update link in the file with the new image name
        sed -i "s|\!\[\[${image_name}\]\]|![${new_image_name}](${new_link})|g" "$file"
        debug_echo "Updated link in file: $file"
    done
}


remove_html_title() {
    local file=$1
    debug_echo "Removing HTML Title"
    sed -i '/<h1> <center><u>.*<\/u><\/center><\/h1>/d' "$file"
}

remove_tldr_lines() {
    local file=$1
    debug_echo "Removing TLDR "
    sed -i '/^> \[!tldr\].*/d' "$file"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -f|--filepath)
            filepath="$2"
            shift # past argument
            shift # past value
            ;;
        -blog)
            destination=$blog_destination_path
            shift # past argument
            ;;
        -docs)
            destination=$docs_destination_path
            shift # past argument
            ;;
        *)
            shift # past argument
            ;;
    esac
done

# Validate input
if [ -z "$filepath" ] || [ -z "$destination" ]; then
    echo "Usage: $0 -f <filepath> (-blog | -docs)"
    exit 1
fi

debug_echo "Arguments parsed. Filepath: $filepath, Destination: $destination"

# Copy file to destination
cp "$filepath" "$destination"
debug_echo "Copied $filepath to $destination"

# Full path of the file at the destination
dest_file="${destination}/$(basename "$filepath")"

# Call functions to modify the file at the destination
remove_html_title "$dest_file"
emove_tldr_lines "$dest_file"

# Update image links in the copied file
update_image_links "$dest_file"

