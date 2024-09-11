#!/bin/bash
# shellcheck disable=2086

# Variables
input="$1"
imagefolder="/home/dylan/Documents/Projets/Astro/flaky-force/src/assets/"
filename=$(basename -- "$input")
filename="${filename%.*}"
content="/home/dylan/Documents/Projets/Astro/flaky-force/src/content/blog/"
dir_path="$content/$filename"

# Create folder if it doesn't exist
if [ -d "$dir_path" ]; then
  echo "Directory $dir_path already exists. Do you want to overwrite? (y/n)"
  read -r confirm
  if [ "$confirm" != "y" ]; then
    echo "Aborting."
    exit 1
  fi
else
  echo "Creating directory $dir_path"
  mkdir -p "$dir_path"
fi

# Copy the markdown file
echo "Copying $input to $dir_path"
cp "$input" "$dir_path/$filename.md"

# Extract tags
echo "Extracting tags from original file"
tags=$(grep -Po 'Tags :#\K.*' "$input")
echo "Tags extracted: $tags"

# Remove specified content
echo "Removing content till </u></center></h1>"
sed_status=$(sed -i '1,/<\/u><\/center><\/h1>/d' "$dir_path/$filename.md" && echo success || echo fail)
echo "Removal operation status: $sed_status"

# Extract introduction
echo "Extracting introduction for description"
description=$(awk '/^# Introduction/{flag=1;next}/^#/{flag=0}flag' "$dir_path/$filename.md")
description=$(echo "$description" | tr '\n' ' ')
echo "Extracted introduction: $description"

# Get current datetime
echo "Getting current datetime"
current_datetime=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "Current datetime: $current_datetime"

# Add new frontmatter
echo "Adding new frontmatter to the copied file"
{
echo "---"
echo "author: Dylan Meunier"
echo "pubDatetime: $current_datetime"
echo "title: $filename"
echo "postSlug: \"\""
echo "featured: false"
echo "draft: false"
echo "tags:"
for tag in $tags; do
  echo "  - $tag"
done
echo "ogImage: \"/src/assets/server1.jpeg\""
echo "description: \"${description}\""
echo "---"
} > "$dir_path/$filename.md.temp"

# Append remaining markdown to temp file
echo "Appending remaining part of the markdown file to temp file"
cat "$dir_path/$filename.md" >> "$dir_path/$filename.md.temp"

# Replace original file with temp file
echo "Replacing the original file with the temp file"
mv "$dir_path/$filename.md.temp" "$dir_path/$filename.md"

# # Check for images and copy them if found
# echo "Checking for images and copying them if found"
# grep -oP '!\[.*\]\(\K[^)]*' "$dir_path/$filename.md" | while read -r img; do
#   img_filename=$(basename -- "$img")
#   if [ -f "$img" ]; then
#     if [ -f "$imagefolder/$img_filename" ]; then
#       echo "Image $img_filename already exists in $imagefolder. Do you want to overwrite it? (y/n)"
#       read -r confirm
#       if [ "$confirm" != "y" ]; then
#         echo "Not overwriting existing image $img_filename."
#         continue
#       fi
#     fi
#     echo "Image found: $img_filename, at path: $img. Copying to $imagefolder."
#     cp "$img" "$imagefolder"
#     sed -i "s|($img)|(/src/assets/$img_filename)|g" "$dir_path/$filename.md"
#     echo "Image $img_filename copied and markdown link updated."
#   else
#     echo "Image $img_filename not found at path: $img!"
#   fi
# done
# Check for images, resize and optimize them, then copy them if found
echo "Checking for images and resizing, optimizing, then copying them if found"
grep -oP '!\[.*\]\(\K[^)]*' "$dir_path/$filename.md" | while read -r img; do
  img_filename=$(basename -- "$img")
  if [ -f "$img" ]; then
    if [ -f "$imagefolder/$img_filename" ]; then
      echo "Image $img_filename already exists in $imagefolder. Do you want to overwrite it? (y/n)"
      read -r confirm
      if [ "$confirm" != "y" ]; then
        echo "Not overwriting existing image $img_filename."
        continue
      fi
    fi
    echo "Image found: $img_filename, at path: $img. Resizing, optimizing and copying to $imagefolder."
    # Resize and optimize the image with resmushit and copy to the image folder
    resmushit "$img" "$imagefolder/$img_filename"
    sed -i "s|($img)|(/src/assets/$img_filename)|g" "$dir_path/$filename.md"
    echo "Image $img_filename resized, optimized, copied and markdown link updated."
  else
    echo "Image $img_filename not found at path: $img!"
  fi
done

echo "Done"
