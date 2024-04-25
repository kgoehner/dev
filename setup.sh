#!/bin/bash
set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    set -x
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Install or update Homebrew
    # https://brew.sh/
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        brew update
    fi

    set -x

    # Install pipx
    brew install pipx
else
    echo "Unsupported OS type: $OSTYPE"
    exit 1
fi

pipx ensurepath

# Install Ansible
pipx install --include-deps ansible

# Clone Setup Repo
git clone https://github.com/Kazz47/dev.git
