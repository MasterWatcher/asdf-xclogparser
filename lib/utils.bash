#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/MasterWatcher/xclogparser"
TOOL_NAME="xclogparser"
TOOL_TEST="xclogparser --help"
TOOL_BUILDPATH=".build/apple/Products/Release/${TOOL_NAME}"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/archive/refs/tags/${version}.tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"
  		cd "$install_path"

    		swift build --configuration release --arch arm64 --arch x86_64

    		if [ ! -d bin ]; then
      		  mkdir bin
    		fi
    		cp -f "$TOOL_BUILDPATH" "bin/$TOOL_NAME"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

                if [ -e "$install_path/$tool_cmd" ]; then
    		  echo "File $install_path/$tool_cmd exists."
                else
                  echo "File $install_path/$tool_cmd does not exist."
                fi
		
                test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
