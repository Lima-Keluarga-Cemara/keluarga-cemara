#!/bin/bash

# Step 1: Check if Homebrew is installed, if not, install it
if ! command -v brew &> /dev/null
then
    echo "Homebrew could not be found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed, skipping..."
fi

# Step 2: Check if Xcodegen is installed, if not, install it
if ! command -v xcodegen &> /dev/null
then
    echo "Xcodegen could not be found, installing..."
    brew install xcodegen
else
    echo "Xcodegen is already installed, skipping..."
fi

# Step 3: Generate Project
echo "Generating Xcode project..."
cd keluarga-cemara
xcodegen generate --use-cache
cd ..

# Step 4: Setup Git Hooks
echo "Setting up Git hooks..."
mkdir -p .git/hooks

# Step 5: Make post-checkout script executable
echo "Making post-checkout hook executable..."
chmod +x git-hooks/post-checkout

# Step 6: Copy the post-checkout script
echo "Copying post-checkout hook..."
cp git-hooks/post-checkout .git/hooks/post-checkout

# Step 7: Make post-pull script executable
echo "Making post-pull hook executable..."
chmod +x git-hooks/post-pull

# Step 8: Copy the post-pull script
echo "Copying post-pull hook..."
cp git-hooks/post-pull .git/hooks/post-pull

echo "Setup complete!"