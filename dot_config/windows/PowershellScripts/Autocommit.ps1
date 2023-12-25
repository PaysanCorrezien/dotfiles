function PersonalAutoCommit {
    $RepoDir = "$env:USERPROFILE\Documents\KnowledgeBase"
    cd $RepoDir

    git add .
    $timestamp = Get-Date -Format "yyyy-MM-dd-HH:mm:ss"

    git commit -m "Auto-commit: $timestamp"

    # Optional: Push to remote repository
    # git push origin main
}
# Call the function
PersonalAutoCommit

