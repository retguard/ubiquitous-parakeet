#!/bin/bash

main() {
    echo -e "Downloading Latest Roblox"
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    curl "https://setup.rbxcdn.com/mac/version-61a8e712340e48b2-RobloxPlayer.zip" -o "./RobloxPlayer.zip"

    echo -e "Installing Latest Roblox"
    [ -d "/Applications/Roblox.app" ] && rm -rf "/Applications/Roblox.app"
    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Applications/Roblox.app
    rm ./RobloxPlayer.zip

    echo -e "Downloading libHydrogen"
    rm ./libHydrogen.dylib
    curl -LJO "https://github.com/retguard/ubiquitous-parakeet/raw/main/libHydrogen.dylib"

    rm ./insert_dylib
    echo -e "Downloading insert_dylib"
    curl -LJO "https://github.com/retguard/legendary-couscous/raw/main/insert_dylib"

    chmod +x "./insert_dylib"

    echo -e "Patching Roblox"
    mv ./libHydrogen.dylib "/Applications/Roblox.app/Contents/MacOS/libHydrogen.dylib"
    ./insert_dylib "/Applications/Roblox.app/Contents/MacOS/libHydrogen.dylib" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    mv "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"

    chmod +x "/Applications/Roblox.app/Contents/MacOS/libHydrogen.dylib"

    rm -rf /Applications/Roblox.app/Contents/MacOS/RobloxPlayerInstaller.ap

    echo -e "Install Complete!"
}

main