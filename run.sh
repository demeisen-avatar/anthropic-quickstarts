#!/bin/bash
set -e

# Check for API key
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "Please set ANTHROPIC_API_KEY environment variable"
    echo "Example: ANTHROPIC_API_KEY=your-key-here ./run.sh"
    exit 1
fi

# Remove existing container if it exists
docker rm -f test 2>/dev/null || true

# Start container
docker run -d \
    -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
    -p 5900:5901 \
    -p 8501:8501 \
    -p 6080:6081 \
    -p 8080:8081 \
    --name test \
    test

echo "✨ Computer Use Demo is ready!"
echo "➡️  Open http://localhost:8080 in your browser to begin"

# Show logs
docker logs -f test
