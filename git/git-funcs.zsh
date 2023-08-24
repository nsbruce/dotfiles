git-track-all() {
    # Adjusted from https://brain2life.hashnode.dev/how-to-make-your-local-repo-track-all-remote-branches-in-git
    git fetch -p
    for remote in `git branch -r`; do
        git branch --track ${remote#origin/} $remote;
    done;
    git branch -a
}