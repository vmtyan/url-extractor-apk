#!/bin/bash
APK_FILE="path to.apk"
OUTPUT_DIR="extractor"
mkdir -p "$OUTPUT_DIR"
apktool d -f "$APK_FILE" -o "$OUTPUT_DIR"
cd "$OUTPUT_DIR"
mkdir -p jars
for dex_file in $(find . -name '*.dex'); do
    d2j-dex2jar "$dex_file" -o "jars/$(basename "$dex_file" .dex).jar"
done
grep -E -o 'https?://[^\"]+' jars/*.jar > urls.txt
grep -E -o '\b(?:\d{1,3}\.){3}\d{1,3}\b' jars/*.jar > ip.txt
