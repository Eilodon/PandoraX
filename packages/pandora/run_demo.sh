#!/bin/bash

# Script để chạy ứng dụng Notes trong Demo Mode
# Hướng dẫn sử dụng: ./run_demo.sh [platform]

set -e

echo "🎭 Notes App Demo Mode Runner"
echo "=============================="

# Parse command line arguments
PLATFORM=${1:-"web"}
VERBOSE=false
TESTS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -t|--tests)
            TESTS=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [platform] [options]"
            echo ""
            echo "Platforms:"
            echo "  web       - Run on web browser (default)"
            echo "  android   - Run on Android device/emulator"
            echo "  ios       - Run on iOS simulator"
            echo "  windows   - Run on Windows"
            echo "  macos     - Run on macOS"
            echo "  linux     - Run on Linux"
            echo ""
            echo "Options:"
            echo "  -v, --verbose   Enable verbose output"
            echo "  -t, --tests     Run test scenarios before starting app"
            echo "  -h, --help      Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                  # Run on web"
            echo "  $0 android -v       # Run on Android with verbose output"
            echo "  $0 web -t           # Run on web after running tests"
            exit 0
            ;;
        *)
            PLATFORM=$1
            shift
            ;;
    esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_step() {
    echo -e "${PURPLE}🔸 $1${NC}"
}

# Check if we're in the correct directory
if [ ! -f "pubspec.yaml" ]; then
    log_error "Please run this script from the pandora package directory"
    exit 1
fi

# Check Flutter installation
if ! command -v flutter &> /dev/null; then
    log_error "Flutter is not installed or not in PATH"
    exit 1
fi

log_info "Preparing Notes App Demo Mode..."

# Step 1: Clean and get dependencies
log_step "Cleaning and getting dependencies..."
if [ "$VERBOSE" = true ]; then
    flutter clean
    flutter pub get
else
    flutter clean > /dev/null 2>&1
    flutter pub get > /dev/null 2>&1
fi
log_success "Dependencies ready"

# Step 2: Run code generation if needed
if [ -f "build.yaml" ]; then
    log_step "Running code generation..."
    if [ "$VERBOSE" = true ]; then
        dart run build_runner build --delete-conflicting-outputs
    else
        dart run build_runner build --delete-conflicting-outputs > /dev/null 2>&1
    fi
    log_success "Code generation complete"
fi

# Step 3: Run tests if requested
if [ "$TESTS" = true ]; then
    log_step "Running test scenarios..."
    if [ -f "test_runner.dart" ]; then
        dart test_runner.dart --report
        log_success "Test scenarios completed"
    else
        log_warning "Test runner not found, skipping tests"
    fi
fi

# Step 4: Create demo environment file
log_step "Setting up demo environment..."
cat > .env.demo << EOF
# Demo Mode Environment Configuration
DEMO_MODE=true
GEMINI_API_KEY=demo_api_key_not_required
FIREBASE_PROJECT=demo-project
USE_MOCK_SERVICES=true

# Mock Service Configuration
MOCK_AI_RESPONSE_DELAY=1000
MOCK_SPEECH_ENABLED=true
MOCK_SYNC_ENABLED=true
MOCK_NOTIFICATIONS_ENABLED=true

# Demo Data Configuration
LOAD_DEMO_NOTES=true
DEMO_USER_ID=demo_user_123
DEMO_ANALYTICS=true

# UI Configuration
SHOW_DEMO_BANNER=true
SHOW_TEST_CONTROLS=true
ENABLE_DEBUG_INFO=true
EOF
log_success "Demo environment configured"

# Step 5: Check platform-specific requirements
case $PLATFORM in
    "android")
        if ! flutter devices | grep -q "android"; then
            log_warning "No Android devices found. Please connect a device or start an emulator."
            log_info "To start an emulator: flutter emulators --launch <emulator_name>"
        fi
        ;;
    "ios")
        if [[ "$OSTYPE" != "darwin"* ]]; then
            log_error "iOS platform is only available on macOS"
            exit 1
        fi
        if ! flutter devices | grep -q "ios"; then
            log_warning "No iOS simulators found. Please start a simulator."
            log_info "To start a simulator: open -a Simulator"
        fi
        ;;
    "web")
        if ! flutter doctor | grep -q "Chrome"; then
            log_warning "Chrome not found. Web apps require Chrome for debugging."
        fi
        ;;
esac

# Step 6: Build and run the app
log_step "Starting Notes App in Demo Mode on $PLATFORM..."

# Set environment variables for the Flutter app
export FLUTTER_ENV=demo
export DEMO_MODE=true

case $PLATFORM in
    "web")
        if [ "$VERBOSE" = true ]; then
            flutter run -d chrome --dart-define=DEMO_MODE=true
        else
            flutter run -d chrome --dart-define=DEMO_MODE=true > /dev/null 2>&1 &
            APP_PID=$!
            log_success "App started in background (PID: $APP_PID)"
            log_info "Access the app at: http://localhost:8080"
            log_info "To stop the app: kill $APP_PID"
        fi
        ;;
    "android")
        flutter run -d android --dart-define=DEMO_MODE=true
        ;;
    "ios")
        flutter run -d ios --dart-define=DEMO_MODE=true
        ;;
    "windows")
        flutter run -d windows --dart-define=DEMO_MODE=true
        ;;
    "macos")
        flutter run -d macos --dart-define=DEMO_MODE=true
        ;;
    "linux")
        flutter run -d linux --dart-define=DEMO_MODE=true
        ;;
    *)
        log_error "Unsupported platform: $PLATFORM"
        log_info "Supported platforms: web, android, ios, windows, macos, linux"
        exit 1
        ;;
esac

# Step 7: Post-launch instructions
echo ""
log_success "🎉 Notes App Demo Mode is now running!"
echo ""
log_info "Demo Mode Features:"
echo "  🤖 AI Chat with mock responses"
echo "  🎤 Speech recognition simulation"
echo "  ☁️  Cloud sync simulation"
echo "  🔔 Mock notifications"
echo "  📊 Demo analytics data"
echo "  📝 Pre-loaded sample notes"
echo ""
log_info "How to use Demo Mode:"
echo "  1. Look for the '🎭 Demo Mode' indicator in the app"
echo "  2. All features work without real API keys or internet"
echo "  3. Use the Demo & Testing screen to run test scenarios"
echo "  4. Toggle Demo Mode on/off in the settings"
echo ""
log_info "Useful commands:"
echo "  dart test_runner.dart           # Run test scenarios"
echo "  dart test_runner.dart -s 'AI'   # Run specific scenario"
echo "  dart test_runner.dart -v -r     # Verbose with HTML report"
echo ""

# Clean up function
cleanup() {
    log_info "Cleaning up demo environment..."
    if [ -f ".env.demo" ]; then
        rm .env.demo
    fi
    log_success "Cleanup complete"
}

# Set trap to cleanup on script exit
trap cleanup EXIT

# Keep script running for background processes
if [ "$VERBOSE" = false ] && [ "$PLATFORM" = "web" ]; then
    echo "Press Ctrl+C to stop the demo..."
    wait $APP_PID
fi
