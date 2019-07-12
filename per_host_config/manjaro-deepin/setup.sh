

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$SCRIPT_DIR" > /dev/null

# Get some color codes
source ../../common_config/bash.d/colors.sh

function strip-comments(){
    grep -v '^#' "$@"
}

# make /usr/local owned by me
sudo chown -R "$(whoami)" /usr/local

echo -e "$(blue Installing local apps ...)"
#sudo apt-get install -y --no-install-recommends $(strip-comments apps.local)
[[ -e ./install.sh ]] && sudo chmod 777 ./install.sh && ./install.sh

# install Github 'hub'
if ! command -v pip3 >> /dev/null; then
    echo -e "$(blue "Installing Pip3..")"
    curl https://bootstrap.pypa.io/get-pip.py | python3
fi

# upgrade PIP
# if there are problems with pip, run curl https://bootstrap.pypa.io/get-pip.py | python3
pip3 install --upgrade pip

echo -e "$(blue Installing python packages ...)"
pip3 install -r python.local

echo -e "$(blue Installing ruby packages ...)"
while read -r line; do 
    if gem list -i "$line" > /dev/null; then
        continue
    fi
    sudo gem install "$line"; 
done < ruby.local 

# Install Yarn - used for instance by coc.vim
if ! command -v yarn >> /dev/null; then
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
fi

# echo -e "$(blue Installing Node packages ...)"
# if command -v pick_json > /dev/null; then
#     installed=$(mktemp)
#     npm list -g --depth 1 --json | pick_json -k -e dependencies > "$installed"

#     #filters out patterns that are present in the other file, see https://stackoverflow.com/questions/4780203/deleting-lines-from-one-file-which-are-in-another-file
#     node_apps=$(grep -v -f "$installed" node.local)
# else
#     node_apps="$(cat node.local)"
# fi
# # if non-zero, https://unix.stackexchange.com/a/146945/18594
# if [[ -n "${node_apps// }" ]]; then
#     sudo npm -g install "$node_apps" 
# fi

# install Github 'hub'
if ! command -v hub >> /dev/null; then
    echo -e "$(blue "Installing Github's Hub...")"
    VERSION="2.3.0-pre10"
    BASENAME="hub-linux-amd64-$VERSION"
    wget "https://github.com/github/hub/releases/download/v${VERSION}/${BASENAME}.tgz"
    tar xvzf "$BASENAME.tgz"
    cd "$BASENAME" || exit
    sudo ./install
    cd ..
    if ! command -v rimraf >> /dev/null; then
        rimraf "${BASENAME}"*
    else
        rm -rf "${BASENAME}"*
    fi
fi

# install /etc files
#sudo cp ./postfix-main.cf /etc/postfix/main.cf

# activate certain bin
# we cannot activate this without knowing we have a working mail system installed in advance, see postfix
#sudo chmod +x /etc/fail2ban/action.d/complain.conf

# restore current directory
popd > /dev/null
