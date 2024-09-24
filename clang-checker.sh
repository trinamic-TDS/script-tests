#!/bin/bash

# Fetch the latest changes from the remote to ensure we are comparing against the latest main branch
git fetch origin main

# Find all files that differ from the main branch HEAD
FILES=$(git diff --name-only --diff-filter=ACM origin/main...HEAD | grep -E '\.(c|cpp|h|hpp)$')

if [ -n "$FILES" ]; then
    echo "Running clang-format on the following files:"
    echo "$FILES"
    
    # Run clang-format and apply changes
    clang-format -i $FILES
    
    # Check if clang-format made any changes
    MODIFIED_FILES_COUNT=$(git diff --name-only --diff-filter=M $FILES | wc -l)
    
    if [ $MODIFIED_FILES_COUNT != 0 ]; then
        echo "clang-format has made changes to the following files:"
        git diff --name-only --diff-filter=M $FILES
        echo "::error::Please apply clang-format changes before committing."
        exit 1
    else
        echo "No formatting changes needed."
    fi
else
    echo "No C/C++ files to check."
fi
