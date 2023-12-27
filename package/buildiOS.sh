cd ..
rm -rf ./build/ios/ipa/mt_markdown.ipa
#rm -rf ./build/app/outputs/flutter-apk/app-release.apk
#rm -rf ./build/app/outputs/flutter-apk/app-debug.apk

#fvm flutter build apk --debug
#./package/pgyer_upload.sh -k 98e445172e8942aece1d0eac22f0270e ./build/app/outputs/flutter-apk/app-debug.apk

fvm flutter build ipa --release --export-options-plist=./package/ExportOptions.plist

#curl -F "file=@./build/ios/ipa/mt_markdown.ipa" -F "uKey=0b7c03ecc4729dd91d670f561f4fc46b" -F "_api_key=98e445172e8942aece1d0eac22f0270e" https://www.pgyer.com/apiv1/app/upload
#fvm flutter build apk --debug
#curl -F "file=@./build/app/outputs/flutter-apk/app-debug.apk" -F "uKey=0b7c03ecc4729dd91d670f561f4fc46b" -F "_api_key=98e445172e8942aece1d0eac22f0270e" https://www.pgyer.com/apiv1/app/upload

./package/pgyer_upload.sh -k 98e445172e8942aece1d0eac22f0270e ./build/ios/ipa/mt_markdown.ipa

