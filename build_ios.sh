#!/bin/sh

flutter build iOS --release --build_number=3
cd ios
fastlane gym -s Runner -w Runner.xcworkspace --configuration Release --export_method app-store --disable_xcpretty true --verbose
fastlane pilot upload -u wzyang@kkbox.com -a net.zonble.iplayground -z
cd ..
