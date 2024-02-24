
# Reset
Color_Off=''

# Regular Colors
Red=''
Green=''
Dim='' # White

# Bold
Bold_White=''
Bold_Green=''

if [[ -t 1 ]]; then
    # Reset
    Color_Off='\033[0m' # Text Reset

    # Regular Colors
    Red='\033[0;31m'   # Red
    Green='\033[0;32m' # Green
    Dim='\033[0;2m'    # White

    # Bold
    Bold_Green='\033[1;32m' # Bold Green
    Bold_White='\033[1m'    # Bold White
fi

error() {
    echo -e "${Red}error${Color_Off}:" "$@" >&2
    exit 1
}

info() {
    echo -e "${Dim}$@ ${Color_Off}"
}

info_bold() {
    echo -e "${Bold_White}$@ ${Color_Off}"
}

success() {
    echo -e "${Green}$@ ${Color_Off}"
}


command -v unzip >/dev/null ||
    error 'unzip is required to install Aardvark'



# https://github.com/Aardvark-team/Aardvark/archive/refs/tags/1.0.0t2.zip

GITHUB=${GITHUB-"https://github.com"}

github_repo="$GITHUB/Aardvark-team/Aardvark"

download_url=$github_repo/archive/refs/tags/1.0.0t2.zip

install_dir=$HOME/.adk
bin_dir=$install_dir/bin
exe=$bin_dir/adk

mkdir -p "$install_dir" ||
    error "Failed to create install directory \"$install_dir\""

curl --fail --location --progress-bar --output "$exe.zip" "$download_url" ||
    error "Failed to download Aardvark from \"$download_url\""

unzip -oqd "$install_dir" "$exe.zip" ||
    error 'Failed to extract Aardvark'

chmod +x "$exe" ||
    error 'Failed to set permissions on bun executable'