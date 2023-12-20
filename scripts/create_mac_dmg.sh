#!/bin/sh
test -f flubox.dmg && rm flubox.dmg
create-dmg \
  --volname "Flubox Installer" \
  --volicon "./assets/flubox_installer.icns" \
  --background "./assets/dmg_background.png" \
  --window-pos 200 120 \
  --window-size 800 530 \
  --icon-size 130 \
  --text-size 14 \
  --icon "Flubox.app" 250 250 \
  --hide-extension "Flubox.app" \
  --app-drop-link 540 250 \
  --hdiutil-quiet \
  "build/macos/Build/Products/Release/Flubox.dmg" \
  "build/macos/Build/Products/Release/Flubox.app"