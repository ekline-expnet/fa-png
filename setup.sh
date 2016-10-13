#!/bin/bash
npm install

./scripts/build_pngs.sh

echo "compiling modified font-awesome sass scss files to css/fontawesome.css"
sass ./scss/fa-png.scss >> ./css/fontawesome.css
