#!/bin/bash

# Script to delete local branches that have been deleted on the remote
# Created: April 20, 2025

echo "Fetching latest information from remote..."
git fetch -p

# Get list of local branches that no longer exist on remote
echo "Identifying local branches that have been deleted on remote..."
deleted_branches=$(git branch -vv | grep ': gone]' | awk '{print $1}')

if [ -z "$deleted_branches" ]; then
  echo "No stale branches found. Your local repository is clean!"
  exit 0
fi

echo "The following local branches no longer exist on the remote:"
echo "$deleted_branches"

# Ask for confirmation before deleting
read -p "Do you want to delete these branches? (y/n): " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
  echo "Deleting branches..."
  echo "$deleted_branches" | xargs git branch -D
  echo "Branches successfully deleted!"
else
  echo "Operation cancelled. No branches were deleted."
fi
