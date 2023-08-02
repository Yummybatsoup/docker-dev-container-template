#! /bin/bash

base=$PWD

while [ ! -e "$base/.git" ];
do
base="$(dirname "$base")"
done

if [ ! -d "$base/.git" ] && grep -q "worktree" "$base/.git"; then
    gitbase=$(cat "$base/.git" | awk -F'gitdir: |/worktrees/' '{print $2}')
else
    gitbase="/dev/null"
fi

echo $gitbase

docker container run --rm -d \
    -v $base:$base `# mount the project` \
    -v $gitbase:$gitbase `# mount the source .git if current project is a git worktree` \
    -v ${HOME}/.ssh:${HOME}/.ssh `# mount ssh for git authenication` \
    test
