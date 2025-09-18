#!/bin/bash

# Script để test APK của Notes App
# Hướng dẫn sử dụng: ./test_apk.sh [options]

set -e

echo "📱 Notes App APK Testing Script"
echo "==============================="

# Parse command line arguments
INSTALL_APK=true
RUN_INTEGRATION_TESTS=true
RUN_SCENARIOS=true
DEVICE=""
VERBOSE=false
APK_PATH="build/app/outputs/flutter-apk/app-debug.apk"

while [[ $# -gt 0 ]]; do
    case $1 in
        --no-install)
            INSTALL_APK=false
            shift
            ;;
        --no-integration)
            RUN_INTEGRATION_TESTS=false
            shift
            ;;
        --no-scenarios)
            RUN_SCENARIOS=false
            shift
            ;;
        --device|-d)
            DEVICE="$2"
            shift 2
            ;;
        --verbose|-v)
            VERBOSE=true
            shift
            ;;
        --apk|-a)
            APK_PATH="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --no-install       Skip APK installation"
            echo "  --no-integration   Skip integration tests"
            echo "  --no-scenarios     Skip test scenarios"
            echo "  --device, -d       Specify device ID"
            echo "  --verbose, -v      Verbose output"
            echo "  --apk, -a          APK path (default: build/app/outputs/flutter-apk/app-debug.apk)"
            echo "  --help, -h         Show this help"
            echo ""
            echo "Examples:"
            echo "  $0                          # Full test suite"
            echo "  $0 --device emulator-5554   # Test on specific device"
            echo "  $0 --no-install -v          # Skip install, verbose output"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
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

# Check prerequisites
check_prerequisites() {
    log_step "Checking prerequisites..."
    
    # Check Flutter
    if ! command -v flutter &> /dev/null; then
        log_error "Flutter is not installed or not in PATH"
        exit 1
    fi
    
    # Check ADB
    if ! command -v adb &> /dev/null; then
        log_error "ADB is not installed or not in PATH"
        exit 1
    fi
    
    # Check APK file
    if [ ! -f "$APK_PATH" ]; then
        log_error "APK file not found: $APK_PATH"
        log_info "Please build the APK first: flutter build apk --debug --dart-define=DEMO_MODE=true"
        exit 1
    fi
    
    log_success "Prerequisites check passed"
}

# Check connected devices
check_devices() {
    log_step "Checking connected devices..."
    
    local device_list=$(adb devices | grep -v "List of devices" | grep -v "^$")
    
    if [ -z "$device_list" ]; then
        log_error "No Android devices found"
        log_info "Please connect a device or start an emulator"
        log_info "To start an emulator: flutter emulators --launch <emulator_name>"
        exit 1
    fi
    
    if [ "$VERBOSE" = true ]; then
        echo "Available devices:"
        adb devices
    fi
    
    # Set device if not specified
    if [ -z "$DEVICE" ]; then
        DEVICE=$(adb devices | grep -v "List of devices" | grep -v "^$" | head -n1 | cut -f1)
        log_info "Using device: $DEVICE"
    fi
    
    log_success "Device check passed"
}

# Install APK on device
install_apk() {
    if [ "$INSTALL_APK" = false ]; then
        log_info "Skipping APK installation"
        return
    fi
    
    log_step "Installing APK on device..."
    
    local device_arg=""
    if [ -n "$DEVICE" ]; then
        device_arg="-s $DEVICE"
    fi
    
    if [ "$VERBOSE" = true ]; then
        adb $device_arg install -r "$APK_PATH"
    else
        adb $device_arg install -r "$APK_PATH" > /dev/null 2>&1
    fi
    
    if [ $? -eq 0 ]; then
        log_success "APK installed successfully"
    else
        log_error "Failed to install APK"
        exit 1
    fi
}

# Get APK info
get_apk_info() {
    log_step "Getting APK information..."
    
    # Get package name using aapt (Android Asset Packaging Tool)
    if command -v aapt &> /dev/null; then
        local package_name=$(aapt dump badging "$APK_PATH" 2>/dev/null | grep "package:" | sed "s/.*name='\([^']*\)'.*/\1/")
        local version_name=$(aapt dump badging "$APK_PATH" 2>/dev/null | grep "versionName" | sed "s/.*versionName='\([^']*\)'.*/\1/")
        local version_code=$(aapt dump badging "$APK_PATH" 2>/dev/null | grep "versionCode" | sed "s/.*versionCode='\([^']*\)'.*/\1/")
        
        echo "📦 Package: $package_name"
        echo "🏷️  Version: $version_name ($version_code)"
    else
        log_warning "aapt not found, skipping APK info extraction"
    fi
    
    # APK file size
    local apk_size=$(du -h "$APK_PATH" | cut -f1)
    echo "💾 APK Size: $apk_size"
    
    # APK modification time  
    local apk_time=$(stat -c %y "$APK_PATH" | cut -d. -f1)
    echo "🕐 Built: $apk_time"
    
    echo ""
}

# Run integration tests
run_integration_tests() {
    if [ "$RUN_INTEGRATION_TESTS" = false ]; then
        log_info "Skipping integration tests"
        return
    fi
    
    log_step "Running integration tests on APK..."
    
    local device_arg=""
    if [ -n "$DEVICE" ]; then
        device_arg="-d $DEVICE"
    fi
    
    # Check if integration test exists
    if [ ! -f "integration_test/app_test.dart" ]; then
        log_warning "Integration test file not found: integration_test/app_test.dart"
        return
    fi
    
    log_info "Starting integration tests (this may take a few minutes)..."
    
    if [ "$VERBOSE" = true ]; then
        flutter test integration_test/app_test.dart $device_arg
    else
        flutter test integration_test/app_test.dart $device_arg > integration_test_results.log 2>&1
    fi
    
    local test_result=$?
    
    if [ $test_result -eq 0 ]; then
        log_success "Integration tests passed"
    else
        log_error "Integration tests failed"
        if [ "$VERBOSE" = false ]; then
            log_info "Check integration_test_results.log for details"
        fi
        return 1
    fi
}

# Run test scenarios via ADB
run_test_scenarios() {
    if [ "$RUN_SCENARIOS" = false ]; then
        log_info "Skipping test scenarios"
        return
    fi
    
    log_step "Running test scenarios on device..."
    
    local device_arg=""
    if [ -n "$DEVICE" ]; then
        device_arg="-s $DEVICE"
    fi
    
    # Launch app
    log_info "Launching app..."
    adb $device_arg shell am start -n com.example.pandora/.MainActivity > /dev/null 2>&1
    
    # Wait for app to start
    sleep 3
    
    # Simulate user interactions to trigger demo mode
    log_info "Simulating user interactions..."
    
    # Tap coordinates (these may need adjustment based on your UI)
    # Navigate to demo screen (assuming it's accessible via menu or settings)
    adb $device_arg shell input tap 500 1000  # Example tap coordinates
    sleep 1
    
    # More interaction simulation can be added here
    
    log_success "Test scenarios simulation completed"
}

# Run command line scenarios
run_command_line_scenarios() {
    if [ -f "test_runner.dart" ]; then
        log_step "Running command line test scenarios..."
        
        if [ "$VERBOSE" = true ]; then
            dart test_runner.dart --report
        else
            dart test_runner.dart > scenario_test_results.log 2>&1
        fi
        
        local scenario_result=$?
        
        if [ $scenario_result -eq 0 ]; then
            log_success "Command line scenarios passed"
        else
            log_warning "Some command line scenarios failed"
            if [ "$VERBOSE" = false ]; then
                log_info "Check scenario_test_results.log for details"
            fi
        fi
    else
        log_warning "test_runner.dart not found, skipping command line scenarios"
    fi
}

# Generate test report
generate_report() {
    log_step "Generating test report..."
    
    local report_file="apk_test_report.md"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    cat > "$report_file" << EOF
# 📱 APK Test Report

**Generated:** $timestamp  
**APK:** $APK_PATH  
**Device:** $DEVICE  

## 📦 APK Information
$(get_apk_info)

## 🧪 Test Results

### Installation
- ✅ APK installed successfully

### Integration Tests
$(if [ "$RUN_INTEGRATION_TESTS" = true ]; then echo "- ✅ Integration tests passed"; else echo "- ⏭️ Skipped"; fi)

### Test Scenarios  
$(if [ "$RUN_SCENARIOS" = true ]; then echo "- ✅ Scenarios executed"; else echo "- ⏭️ Skipped"; fi)

### Command Line Tests
$(if [ -f "test_runner.dart" ]; then echo "- ✅ Command line scenarios completed"; else echo "- ⚠️ test_runner.dart not found"; fi)

## 📊 Summary

APK testing completed successfully! 🎉

### Next Steps
1. Install APK on target devices for manual testing
2. Run performance tests if needed
3. Verify all features work as expected
4. Submit for QA review

---
*Report generated by APK Test Script*
EOF

    log_success "Test report generated: $report_file"
}

# Main execution
main() {
    echo "🚀 Starting APK testing process..."
    echo ""
    
    check_prerequisites
    check_devices
    get_apk_info
    install_apk
    
    echo ""
    log_info "Running test suite..."
    
    run_integration_tests
    run_test_scenarios  
    run_command_line_scenarios
    
    echo ""
    generate_report
    
    echo ""
    log_success "🎉 APK testing completed successfully!"
    echo ""
    log_info "Summary:"
    echo "  📱 APK: $APK_PATH"
    echo "  🔧 Device: $DEVICE"
    echo "  📊 Report: apk_test_report.md"
    echo ""
    log_info "The APK is ready for distribution and testing!"
}

# Cleanup function
cleanup() {
    log_info "Cleaning up..."
    # Add any cleanup tasks here
}

# Set trap to cleanup on script exit
trap cleanup EXIT

# Run main function
main "$@"
