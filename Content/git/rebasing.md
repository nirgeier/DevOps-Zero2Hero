## Rebasing

Git rebasing lets you move or reapply commits onto a new base commit. It’s a powerful way to maintain a tidy, linear project history.

There are two main ways to use the `git rebase` command :

### 1. As an alternative to merging:
    
  We can rebase the branch onto the master branch. this moves the entire current branch so it begins at the tip of the master branch. All of the work is still there, but we have re-written the history of the branch.
  
  
  ```bash
  git switch branch-name 
  git rebase main
  ```

  This takes all commits from `branch-name` that are not in the `main`, and repositions them on top of the `main` branch.
 
  **Why rebase?**
  
  We get a much cleaner project history, no unnecessary merge commits. 
  
  **Warning!**
  
  Never rebase commits that have been shared with others. If you have pushed commits up to Github do not rebase them. 
  Rebasing rewrites commit history, which can cause problems if someone else has already based work on those commits. To avoid confusion or conflicts, it’s best to rebase while your branch is still private—before pushing it to a shared repository or opening a pull request.
  Once others have access to the commits, use merge instead to preserve shared history safely.
  
  A conflict?
  Follow the output that git provides you.
    


### 2. As a cleanup tool:
    
  Sometimes we want to rewrite, delete, rename, or reorder commits (before sharing them). We can do this using git rebase. 
  
  `git rebase -i HEAD~n` - Will open a list of your last `n` commits and enters interactive mode, which allows you to:
  - `pick` - keep the commit
  - `reword` - change the commit message
  - `squash` - combine commits
  - `drop` - delete a commit
  

        