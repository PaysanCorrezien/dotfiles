# Set session root path. Default is `$HOME`.
# Must be called before `new_window`.
session_root "/home/dylan/Documents/Projets/Astro/flaky-force"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "main"
run_cmd "lvim -c 'telescope fd'"

new_window "dev"
run_cmd "npm run dev"

new_window "content"
run_cmd "cd content/src"

new_window "conversion"

select_window 1


# Create new window, run command and set as active.
#new_window "public" "htop"

