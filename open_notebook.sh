#!/bin/bash

echo Open http://localhost:8888/ in a browser
echo ""
jupyter notebook --ip='*' --port=8888 --no-browser
