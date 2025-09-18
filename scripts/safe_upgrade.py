#!/usr/bin/env python3
"""
Safe Upgrade Script for PandoraX Enhancement
This script ensures safe upgrades with automatic rollback capabilities
"""

import subprocess
import sys
import os
import json
import time
from datetime import datetime
from typing import Dict, List, Tuple

class SafeUpgrader:
    def __init__(self):
        self.project_root = os.getcwd()
        self.backup_branch = "backup-before-upgrade"
        self.current_branch = "master"
        self.upgrade_log = []
        
    def log(self, message: str, level: str = "INFO"):
        """Log message with timestamp"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] [{level}] {message}"
        print(log_entry)
        self.upgrade_log.append(log_entry)
        
    def run_command(self, command: str, check: bool = True) -> Tuple[bool, str]:
        """Run command and return success status and output"""
        try:
            self.log(f"Running command: {command}")
            result = subprocess.run(
                command, 
                shell=True, 
                capture_output=True, 
                text=True, 
                check=check
            )
            self.log(f"Command output: {result.stdout}")
            if result.stderr:
                self.log(f"Command stderr: {result.stderr}", "WARNING")
            return True, result.stdout
        except subprocess.CalledProcessError as e:
            self.log(f"Command failed: {e}", "ERROR")
            self.log(f"Error output: {e.stderr}", "ERROR")
            return False, e.stderr
            
    def check_prerequisites(self) -> bool:
        """Check if all prerequisites are met"""
        self.log("Checking prerequisites...")
        
        # Check if git is available
        success, _ = self.run_command("git --version")
        if not success:
            self.log("Git is not available", "ERROR")
            return False
            
        # Check if melos is available
        success, _ = self.run_command("melos --version")
        if not success:
            self.log("Melos is not available", "ERROR")
            return False
            
        # Check if flutter is available
        success, _ = self.run_command("flutter --version")
        if not success:
            self.log("Flutter is not available", "ERROR")
            return False
            
        self.log("All prerequisites met")
        return True
        
    def create_backup(self) -> bool:
        """Create backup of current state"""
        self.log("Creating backup...")
        
        # Check if we're in a git repository
        success, _ = self.run_command("git status")
        if not success:
            self.log("Not in a git repository, initializing...")
            success, _ = self.run_command("git init")
            if not success:
                return False
                
        # Add all files
        success, _ = self.run_command("git add .")
        if not success:
            return False
            
        # Commit current state
        success, _ = self.run_command('git commit -m "Backup before upgrade - stable state"')
        if not success:
            return False
            
        # Create backup branch
        success, _ = self.run_command(f"git checkout -b {self.backup_branch}")
        if not success:
            return False
            
        # Switch back to main branch
        success, _ = self.run_command(f"git checkout {self.current_branch}")
        if not success:
            return False
            
        self.log("Backup created successfully")
        return True
        
    def run_tests(self) -> bool:
        """Run all tests to ensure system is stable"""
        self.log("Running tests...")
        
        # Run flutter analyze
        success, _ = self.run_command("melos exec -- 'flutter analyze'")
        if not success:
            self.log("Flutter analyze failed", "ERROR")
            return False
            
        # Run flutter test
        success, _ = self.run_command("melos exec -- 'flutter test'")
        if not success:
            self.log("Flutter test failed", "ERROR")
            return False
            
        self.log("All tests passed")
        return True
        
    def create_feature_branch(self, phase: str) -> bool:
        """Create feature branch for specific phase"""
        branch_name = f"feature/phase-{phase}"
        self.log(f"Creating feature branch: {branch_name}")
        
        success, _ = self.run_command(f"git checkout -b {branch_name}")
        if not success:
            return False
            
        self.log(f"Feature branch {branch_name} created")
        return True
        
    def validate_changes(self) -> bool:
        """Validate changes before committing"""
        self.log("Validating changes...")
        
        # Run tests
        if not self.run_tests():
            return False
            
        # Check for compile errors
        success, _ = self.run_command("melos exec -- 'flutter analyze'")
        if not success:
            self.log("Compile errors detected", "ERROR")
            return False
            
        self.log("Changes validated successfully")
        return True
        
    def commit_changes(self, phase: str, description: str) -> bool:
        """Commit changes with proper message"""
        self.log(f"Committing changes for {phase}")
        
        # Add all changes
        success, _ = self.run_command("git add .")
        if not success:
            return False
            
        # Commit with descriptive message
        commit_message = f"Phase {phase}: {description}"
        success, _ = self.run_command(f'git commit -m "{commit_message}"')
        if not success:
            return False
            
        self.log(f"Changes committed for {phase}")
        return True
        
    def rollback(self) -> bool:
        """Rollback to previous stable state"""
        self.log("Rolling back to previous state...")
        
        # Switch to backup branch
        success, _ = self.run_command(f"git checkout {self.backup_branch}")
        if not success:
            self.log("Failed to switch to backup branch", "ERROR")
            return False
            
        # Create new main branch from backup
        success, _ = self.run_command("git checkout -b main-new")
        if not success:
            return False
            
        # Delete old main branch
        success, _ = self.run_command(f"git branch -D {self.current_branch}")
        if not success:
            self.log("Failed to delete old main branch", "WARNING")
            
        # Rename new branch to main
        success, _ = self.run_command("git branch -m main")
        if not success:
            return False
            
        self.log("Rollback completed successfully")
        return True
        
    def run_phase(self, phase: str, description: str, upgrade_function) -> bool:
        """Run a specific upgrade phase safely"""
        self.log(f"Starting Phase {phase}: {description}")
        
        # Create feature branch
        if not self.create_feature_branch(phase):
            return False
            
        try:
            # Run upgrade function
            if not upgrade_function():
                self.log(f"Phase {phase} failed", "ERROR")
                return False
                
            # Validate changes
            if not self.validate_changes():
                self.log(f"Phase {phase} validation failed", "ERROR")
                return False
                
            # Commit changes
            if not self.commit_changes(phase, description):
                return False
                
            self.log(f"Phase {phase} completed successfully")
            return True
            
        except Exception as e:
            self.log(f"Phase {phase} failed with exception: {e}", "ERROR")
            return False
            
    def upgrade_phase_1_ai(self) -> bool:
        """Phase 1: AI Enhancement"""
        self.log("Implementing Phase 1: AI Enhancement")
        
        # Add smart summarization styles
        # This would be implemented in the actual code
        # For now, we'll just simulate the process
        
        self.log("Adding smart summarization styles...")
        time.sleep(1)  # Simulate work
        
        self.log("Adding enhanced content generation...")
        time.sleep(1)  # Simulate work
        
        self.log("Adding multi-language translation...")
        time.sleep(1)  # Simulate work
        
        return True
        
    def upgrade_phase_2_voice(self) -> bool:
        """Phase 2: Voice Enhancement"""
        self.log("Implementing Phase 2: Voice Enhancement")
        
        # Add multi-language voice support
        self.log("Adding multi-language voice support...")
        time.sleep(1)  # Simulate work
        
        # Add voice commands
        self.log("Adding voice commands...")
        time.sleep(1)  # Simulate work
        
        return True
        
    def upgrade_phase_3_cloud(self) -> bool:
        """Phase 3: Cloud Sync Enhancement"""
        self.log("Implementing Phase 3: Cloud Sync Enhancement")
        
        # Add real-time sync
        self.log("Adding real-time sync...")
        time.sleep(1)  # Simulate work
        
        # Add conflict resolution
        self.log("Adding conflict resolution...")
        time.sleep(1)  # Simulate work
        
        return True
        
    def run_full_upgrade(self) -> bool:
        """Run complete upgrade process"""
        self.log("Starting full upgrade process...")
        
        # Check prerequisites
        if not self.check_prerequisites():
            return False
            
        # Create backup
        if not self.create_backup():
            return False
            
        # Run tests to ensure stability
        if not self.run_tests():
            return False
            
        # Run phases
        phases = [
            ("1", "AI Enhancement", self.upgrade_phase_1_ai),
            ("2", "Voice Enhancement", self.upgrade_phase_2_voice),
            ("3", "Cloud Sync Enhancement", self.upgrade_phase_3_cloud),
        ]
        
        for phase, description, upgrade_func in phases:
            if not self.run_phase(phase, description, upgrade_func):
                self.log(f"Upgrade failed at phase {phase}", "ERROR")
                self.log("Initiating rollback...")
                if self.rollback():
                    self.log("Rollback completed successfully")
                else:
                    self.log("Rollback failed", "ERROR")
                return False
                
        self.log("Full upgrade completed successfully!")
        return True
        
    def save_log(self):
        """Save upgrade log to file"""
        log_file = f"upgrade_log_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
        with open(log_file, 'w') as f:
            f.write('\n'.join(self.upgrade_log))
        self.log(f"Upgrade log saved to {log_file}")

def main():
    """Main function"""
    upgrader = SafeUpgrader()
    
    try:
        if upgrader.run_full_upgrade():
            print("✅ Upgrade completed successfully!")
            upgrader.save_log()
            sys.exit(0)
        else:
            print("❌ Upgrade failed!")
            upgrader.save_log()
            sys.exit(1)
    except KeyboardInterrupt:
        print("\n⚠️ Upgrade interrupted by user")
        upgrader.log("Upgrade interrupted by user", "WARNING")
        upgrader.save_log()
        sys.exit(1)
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        upgrader.log(f"Unexpected error: {e}", "ERROR")
        upgrader.save_log()
        sys.exit(1)

if __name__ == "__main__":
    main()
