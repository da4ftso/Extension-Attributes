#!/bin/zsh

# 1.2 261109
#
# based on: 
#  https://github.com/mpermann/Get_Homebrew_Python_Vers/blob/main/Get_Homebrew_Python_Vers.sh
#  https://github.com/mpermann/Get_Python.org_Python_Vers/blob/main/Get_Python.org_Vers.sh
#  https://github.com/da4ftso/Extension-Attributes/blob/master/Dev/Homebrew%20Version.sh
#
# Reports Python 3 versions installed from:
#   - Homebrew
#   - Python.org
#   - /usr/bin
#   - Xcode Command Line Tools
#   - Full Xcode installations
#
# This script only examines system-wide paths. It does not depend on a
# logged-in user and can run as root while the Mac is at loginwindow.

results=()

function add_result() {
    local pythonPath="$1"
    local source="$2"
    local version=""
    local entry=""

    [[ -x "$pythonPath" ]] || return

    version=$(
        "$pythonPath" --version 2>&1 |
            /usr/bin/awk '/^Python / {print $2; exit}'
    )

    [[ -n "$version" ]] || return

    entry="${version} (${source})"

    # Avoid duplicate version/source combinations
    if (( ${results[(Ie)$entry]} == 0 )); then
        results+=("$entry")
    fi
}

function find_python_versions() {
    local searchPath="$1"
    local source="$2"
    local pythonPath=""

    [[ -d "$searchPath" ]] || return

    while IFS= read -r -d '' pythonPath; do
        add_result "$pythonPath" "$source"
    done < <(
        /usr/bin/find "$searchPath" \
            \( -type f -o -type l \) \
            -name python3 \
            -print0 2>/dev/null
    )
}

#
# Homebrew Python
#
# Check both prefixes instead of relying only on the current architecture.
# This also detects an Intel Homebrew installation retained on Apple silicon.

find_python_versions "/opt/homebrew/Cellar" "Homebrew"
find_python_versions "/usr/local/Cellar" "Homebrew"

#
# Python.org installer
#

find_python_versions \
    "/Library/Frameworks/Python.framework/Versions" \
    "Python.org"

#
# Apple-provided /usr/bin Python
#

add_result "/usr/bin/python3" "Apple /usr/bin"

#
# Xcode Command Line Tools
#

find_python_versions \
    "/Library/Developer/CommandLineTools" \
    "Xcode Command Line Tools"

#
# Full Xcode installations
#
# This detects Xcode.app as well as named copies such as:
#   Xcode-16.1.app
#   Xcode-beta.app

while IFS= read -r -d '' xcodeApp; do
    xcodeName="${xcodeApp:t:r}"

    find_python_versions \
        "${xcodeApp}/Contents/Developer" \
        "${xcodeName}"
done < <(
    /usr/bin/find /Applications \
        -maxdepth 1 \
        -type d \
        -name "Xcode*.app" \
        -print0 2>/dev/null
)

#
# Jamf EA result
#

if (( ${#results[@]} == 0 )); then
    echo "<result>None</result>"
else
    echo "<result>${(j:, :)results}</result>"
fi

exit 0
