#! /bin/bash

name=dev

# -------------------------------- #

# find the project base by locating .git
base=$PWD
while [ ! -e "$base/.git" ];
do
base="$(dirname "$base")"
done

# for project created by git worktree, we need to locate source .git and mount it to make git work
if [ ! -d "$base/.git" ] && grep -q "worktrees" "$base/.git"; then
    gitbase=$(cat "$base/.git" | awk -F'gitdir: |/worktrees/' '{print $2}')
else
    gitbase="/dev/null"
fi

docker rm -f $name
docker run -itd --name $name \
	--gpus all \
    -v $base:$base                `# mount the project` \
    -v $gitbase:$gitbase          `# mount the source .git if current project is a git worktree` \
    -v ${HOME}/.ssh:${HOME}/.ssh  `# mount ssh for git authenication` \
	-p 20000:20000 \
    $name

