# Basic Git commands Used
Git is a version control software tool which tracks the files changed and those changes will be pushed to remote for sharing code among the team members.

Need to set the basic details in the git system before pushing the changes to remote such as Authentication, Username & E-Mail. Such that, they can be recognised in the remote for blame details

## (1/4) How to clone a Project
1. Take the URL of the project and use the command below in the command prompt or git bash terminal
2. `git clone <URL of the project>`
3. Checkout (or) Move to the branch in which you can make the changes by below command
4. `git checkout <Feature Branch Name>`
5. To see in which branch you're currently working in
6. `git branch`

## (2/4) How to push changes to remote from local
1. Check the files in which changes made are being tracked by git
2. `git status`
3. Remove the files if those changes not to be pushed to remote
4. `Google Search and do the needful`
5. Validate the changes made for *before* & *after* results
6. `git diff`
7. Add file to staging location which will be committed and pushed to remote later  
  a. `git add .` add all changed files to staging  (or)  
  b. `git add <Filename>` add the specific given file to staging  
9. Now commit the changes in local with a message about the changes
10. `git commit -m "<Message about the changes>"`  
    a. If needed, now run the *MVN build* of the project to confirm the code is not breaking
12. Ready push the commits which are in local not in remote  
    a. `git status`: See list of commits made in local not yet pushed to remote  
    b. Push to remote: `git push origin <Feature Branch Name>` (or) `git push <remote-branch-name> <local-name-of-branch>`  

## (3/4) Git Merge 
Merge Main from remote into local feature branch without committing to see if any conflicts exist.  

_Conflict occurs when Dev1 created Branch1 from MAIN1.0 and Dev2 created  Branch2 from MAIN1.0. Dev2 made his changes in **line 101** and merged to main and main changes to MAIN2.0. Now Dev1 tries to merge Branch1 to Main2.0 with changes at **line 101** git is confused, which changes to keep in remote as original MAIN1.0 is not there in the remote and MAIN2.0 **line 101** is not as expected by Branch1 base viz MAIN1.0. Dev only need to decide, whether to keep both changes or remove Dev2 changes or remove Dev1 changes based on the requirment._  

1. `git checkout <Feature-Branch>`
2. `git fetch origin`
3. `git merge origin/main --no-commit`
4. Now action accodingly if conflict occurs and didn't occur

    #### CASE-1: Conflict with the remote Main 
    Merge process stops abruptly, open each file  based on `git status` and resolve them accordingly
   
    5. `git status` see the list of files in which conflict occured  
    6. `git diff` see the conflicts by opening each file from the above list  
        _**Merge Conflict will be shown as below**_  
        &ensp; `<<<<<<< HEAD` _Dev1 Changes_ `=======` _Current code in MAIN2.0_ `>>>>>>>`  
        &ensp; `<<<<<<< HEAD` _Source Changes viz Local_ `=======` _Destination code viz MAIN2.0 / remote_ `>>>>>>>`
    8. `git mergetool` see the conflicts visually via merge tool and solve them accordingly  
    9. `git merge --abort` abort the merge process  
    
    #### CASE-2: No conflict with the remote Main 
    5. `git diff --cached` see the changes in staged files as merge completed
    6. `git merge --continue` commit the changes & continue
    7. Push changes to remote if needed
    8. `git merge --abort` abort the merge process

## (4/4) Git Utility Commands
**Commit History**
1. `git log`
2. `git show <Commit ID>`
3. `git show --name-only <Commit ID> `
4. `git commit --amend` To modify recent commit  

**Delete Local Commits**
1. `git reset --hard origin<Branch Name>` Reset Local as per remote: 
2. `git reset --soft HEAD~1` Delete latest commit in local and keep changes in staging location, *1* reperesent the number of recent commit here its top most 1
3. `git reset HEAD~1` Delete latest commit in local, remove from staging location and keep in tracking list
4. `git reset --hard HEAD~1` Delete latest commit in local, remove from staging location and remove tracking list also, *Move local to previous commit and remove top commit everything*

**Fast Forward Branch** 
Update feature branch to main branch version if no commits are made in feature branch after its creation to till date
1. `git checkout <Feature Branch Name>`
2. `git merge main --ff`

**Stash** 
When you want to move to other branch and don't want to commit the current changes, the best way is to save the changes in a temporary memory
1. Save to memory  
   a. `git stash save "Message of changes"`  
2. Take from memory and apply after comming back to branch  
  a. `git stash apply` apply all in memory to branch   
  b. `git stash apply stash@{3}` apply specific one in the memory list   
  c. `git stash pop` apply recent in memory to branch  
3. See memory  
  a. `git stash list` all in stash  
  b. `git stash list --stat` for stats  
3. Remove from memory  
  a. `git stash drop` top one in memory   
  b. `git stash drop <name>` specific from memory  
  c. `git stash clear` all in memory   

**Ignore**  
`gitignore <Filename to Ignore>`  

**Cherry-Pick**   
`Google for exact use requirement` select the each commit which you want to have in the branch or push to main later.  

**Revert**   
`git revert <commit-sha>` helps you to undo a mistake or a change that you no longer need. Creates a new commit that undoes the changes made in a previous commit.   

**Blame**  
`git blame <file_name>`  (or) `git blame -L <line_start>, <line_end>`

**Bisect**  
`git bisect` Seeing each commit and marking as good or bad for defect tracking a commit. See below example  

_git bisect start  
git bisect bad                 # Current version is bad  
git bisect good v2.6.13-rc2    # v2.6.13-rc2 is known to be good_  

**Reflog**  
`git reflog`  

**Difference Tool**  
Used to visually see difference between any two side by side, useful when reviewing someone's commits and also validating the changes
1. `git difftool HEAD~1 HEAD` see differences between the latest commits
2. `git difftool <Branch1>..<Branch2>` see differences between two branches
3. `git difftool --staged` see differences between the staged files and latest commit
4. Stop difftool is *CTRL + C*

_Difference Tool Vertical Layout:_ It's a 2 window screen  
&ensp; Left window<sup>1</sup>: BASE/ORIGINAL  
&ensp; Right Window<sup>2</sup>: Modified Version

**Merge Tool**   
It'll show one file at a time with the conflicts
1. Start the tool: `git difftool -t <Tool Name>` (or) `git difftool` to see conflicts after trying to merge
2. Switch between the windows: `CTRL+W, W`
3. Set line number to each window manually: `:set number`
4. Close all windows without saving changes: `:qa!`

_Merge Tool Layout:_  It's 4 window screen  
&ensp;Local<sup>1</sup>  || Base / Original<sup>2</sup>  || Current in Main<sup>3</sup>  
&ensp;&ensp;&nbsp;&ensp;&nbsp; Final after resolving conflicts<sup>4</sup>

*Color Coding of VimDiff Tool*
1. Pink Line [Modified Line]: Line is Modified
2. Pink Line has Red Highlighted [Modified Line (Changed Position) **Red Color**]: Specific location where changes were made
3. Cyan dotted line [----------]: Void / Null line / Nothing in that location
4. Dark Blue [New insertion in-between lines]: Newly added lines in place of empty/void  

**Visual Representation of the VimDiff Tool**  

![image](https://github.com/user-attachments/assets/85a6b461-5ceb-4deb-92b4-0d3a76e2ac3d)


  _**The END**_
