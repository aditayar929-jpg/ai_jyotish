#!/bin/bash
cd ~/ai_jyotish
URL="https://github.com/aditayar929-jpg/ai_jyotish.git"
git remote remove origin 2>/dev/null
git remote add origin "$URL"
git push -u origin master --force
