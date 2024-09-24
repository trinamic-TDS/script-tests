#!/bin/bash
# echo "Aborting commit. Please manually review and commit changes."
# Run clang-format on all staged C/C++ files
# Finds all staged .c, .h, .cpp, .hpp files and runs clang-format on them
# Allows us to read user input below, assigns stdin to keyboard
exec < /dev/tty

FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(c|cpp|h|hpp)$')

if [ -n "$FILES" ]; then
    # Run clang-format and apply changes
    echo "Running clang-format on staged files..."
    clang-format -i $FILES

    # Check if clang-format made any changes
    MODIFIED_FILES_COUNT=$(git diff --name-only --diff-filter=M $FILES | wc -l)

    if [ $MODIFIED_FILES_COUNT != 0 ]; then
        echo "clang-format has made changes to the following files:"
        git diff --name-only --diff-filter=M $FILES

        # Prompt the user for acceptance
        read -p "Do you want to accept clang-format changes and include them in the commit? (y/n): "
        
        if [ "$REPLY" == "y" ] ;then
            # Stage the formatted files
            git add $FILES
        else
            echo "Aborting commit. Please manually review and commit changes."
            exit 1
        fi
    else
        echo "No formatting changes needed."
    fi
fi

# Proceed with the commit