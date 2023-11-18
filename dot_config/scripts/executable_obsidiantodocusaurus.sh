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
image_source_path="/mnt/c/Users/dylan/Documents/Obsidian Vault/Zettelkasten/Files/"
blog_destination_path="/mnt/c/Users/dylan/Documents/Projet/Work/Projet/blog2023/blog/"
docs_destination_path="/mnt/c/Users/dylan/Documents/Projet/Work/Projet/blog2023/docs/KnowledgeBase/"
remote_image_path="/mnt/c/Users/dylan/Documents/Projet/Work/Projet/blog2023/static/img/"  # This path ends with 'assets/'

debug_echo "Paths set. Image source: $image_source_path, Blog dest: $blog_destination_path, Docs dest: $docs_destination_path, Remote image path: $remote_image_path"

# Function to extract image names and update links
update_image_links() {
    local file=$1
    local image_name

    debug_echo "Updating image links in file: $file"

    # Extract image names and update links
    grep -oP '!\[.*?\]\(\K.*?(?=\))' "$file" | while read -r image_link; do
        image_name=$(basename "$image_link")

        debug_echo "Processing image: $image_name from link: $image_link"

        # Copy image from source to remote path
        cp "${image_source_path}/${image_name}" "${remote_image_path}/${image_name}"
        debug_echo "Copied $image_name to $remote_image_path"

        # Build new link
        new_link="/static/img/${image_name}"  # Updated link format
        debug_echo "New link: $new_link"

        # Update link in the file
        sed -i "s|${image_link}|${new_link}|g" "$file"
        debug_echo "Updated link in file: $file"
    done
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

# Update image links in the copied file
update_image_links "${destination}/$(basename "$filepath")"
