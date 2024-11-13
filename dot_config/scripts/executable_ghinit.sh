# Function to print status messages with emojis
print_status() {
	echo "🔄 $1"
}
print_success() {
	echo "✅ $1"
}
print_error() {
	echo "❌ $1"
	exit 1
}

convert_to_ssh() {
	print_status "Converting remote URL to SSH format..."
	current_url=$(git config --get remote.origin.url)
	echo "Current URL: $current_url"
	if [[ $current_url == https://github.com/* ]]; then
		new_url=$(echo $current_url | sed 's|https://github.com/|git@github.com:|')
		git remote set-url origin "$new_url"
		print_success "Updated URL: $new_url"
	else
		print_status "No change needed - already using SSH format"
	fi
}

setup_repo() {
	local repo_name=$1
	local visibility=$2
	username=$(gh api user -q '.login')
	# Check if repo exists
	if gh repo view "$username/$repo_name" &>/dev/null; then
		print_status "Repository already exists, setting up remote..."
		repo_url="git@github.com:$username/$repo_name.git"
	else
		print_status "Creating new repository: $repo_name..."
		gh repo create "$repo_name" --source=. "--$visibility" || print_error "Failed to create repository"
		repo_url="https://github.com/$username/$repo_name.git"
	fi
	if ! git remote get-url origin &>/dev/null; then
		git remote add origin "$repo_url"
	else
		git remote set-url origin "$repo_url"
	fi
	print_success "Remote 'origin' configured!"
}

# Check if required tools are installed
print_status "Checking required tools..."
if ! command -v gh &>/dev/null; then
	print_error "GitHub CLI is not installed. Please install it first."
fi
if ! command -v gum &>/dev/null; then
	print_error "Gum is not installed. Please install it first. (brew install gum)"
fi

# Check GitHub CLI authentication
print_status "Checking GitHub CLI authentication..."
if ! gh auth status &>/dev/null; then
	print_error "Not authenticated with GitHub. Please run 'gh auth login' first."
fi
print_success "GitHub CLI is ready to use!"

# Check if we're in a git repository
print_status "Checking git repository status..."
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
	print_status "Not in a git repository. Initializing..."
	git init
	print_success "Git repository initialized!"
	# Initial commit
	print_status "Preparing initial commit..."
	if [ -z "$(git status --porcelain)" ]; then
		echo "README.md" >README.md
		git add README.md
	else
		git add .
	fi
	commit_message=$(gum input --placeholder "Enter commit message" --value "Initial commit")
	git commit -m "$commit_message"
	print_success "Initial commit created!"
else
	print_success "Already in a git repository!"
fi

# Get repository name with current folder name as default
current_folder=$(basename $(pwd))
repo_name=$(gum input --placeholder "Enter repository name" --value "$current_folder")

# Choose visibility with private as default
visibility=$(gum choose --selected "private" "private" "public")

setup_repo "$repo_name" "$visibility"

# Convert to SSH first
convert_to_ssh

# Push to GitHub after SSH conversion
print_status "Pushing to GitHub..."
git push -u origin $(git rev-parse --abbrev-ref HEAD)

# Verify remote configuration
print_status "Verifying remote configuration..."
if git remote get-url origin &>/dev/null; then
	print_success "Remote 'origin' is properly configured!"
	echo "🌟 Remote URL: $(git remote get-url origin)"
	echo "🎉 Repository setup complete! Your code is now on GitHub!"
else
	print_error "Remote 'origin' is not configured properly"
fi
