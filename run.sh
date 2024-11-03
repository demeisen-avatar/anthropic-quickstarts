#!/bin/bash
set -e

cd "$(dirname "$0")"

# Source port configuration
source computer-use-demo/.ports || {
    echo "Error: Failed to load port configuration from computer-use-demo/.ports"
    exit 1
}

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
    -v "$(pwd)/computer-use-demo":/host \
    -p ${PORT_VNC_EXTERNAL}:${PORT_VNC_INTERNAL} \
    -p ${PORT_STREAMLIT_EXTERNAL}:${PORT_STREAMLIT_INTERNAL} \
    -p ${PORT_NOVNC_EXTERNAL}:${PORT_NOVNC_INTERNAL} \
    -p ${PORT_HTTP_EXTERNAL}:${PORT_HTTP_INTERNAL} \
    --name test \
    test

echo "✨ Computer Use Demo is ready!"
echo "➡️  Open http://localhost:${PORT_HTTP_EXTERNAL} in your browser to begin"

# Show logs
docker logs -f test
