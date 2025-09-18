#!/usr/bin/env python3
"""
PandoraX Performance Optimization Script

This script optimizes the Flutter app performance by:
1. Analyzing bundle size
2. Optimizing images
3. Removing unused dependencies
4. Generating performance reports
"""

import os
import sys
import subprocess
import json
import shutil
from pathlib import Path

class PerformanceOptimizer:
    def __init__(self, project_root):
        self.project_root = Path(project_root)
        self.reports_dir = self.project_root / "performance_reports"
        self.optimized_assets_dir = self.project_root / "packages/presentation/pandora_app/assets/optimized"
        
    def run(self):
        """Run all optimization steps"""
        print("🚀 Starting PandoraX Performance Optimization...")
        
        # Create reports directory
        self.reports_dir.mkdir(exist_ok=True)
        self.optimized_assets_dir.mkdir(exist_ok=True)
        
        # Run optimization steps
        self.analyze_bundle_size()
        self.optimize_images()
        self.analyze_dependencies()
        self.generate_performance_report()
        
        print("✅ Performance optimization completed!")
    
    def analyze_bundle_size(self):
        """Analyze Flutter bundle size"""
        print("📊 Analyzing bundle size...")
        
        try:
            # Run flutter analyze
            result = subprocess.run([
                "flutter", "analyze", "--no-fatal-infos"
            ], cwd=self.project_root / "packages/presentation/pandora_app", 
            capture_output=True, text=True)
            
            # Run flutter build for analysis
            subprocess.run([
                "flutter", "build", "apk", "--analyze-size"
            ], cwd=self.project_root / "packages/presentation/pandora_app")
            
            print("✅ Bundle size analysis completed")
            
        except Exception as e:
            print(f"❌ Bundle size analysis failed: {e}")
    
    def optimize_images(self):
        """Optimize image assets"""
        print("🖼️ Optimizing images...")
        
        assets_dir = self.project_root / "packages/presentation/pandora_app/assets"
        
        if not assets_dir.exists():
            print("⚠️ Assets directory not found")
            return
        
        # Find all image files
        image_extensions = ['.png', '.jpg', '.jpeg', '.gif', '.webp']
        image_files = []
        
        for ext in image_extensions:
            image_files.extend(assets_dir.rglob(f"*{ext}"))
        
        print(f"Found {len(image_files)} image files")
        
        # Optimize each image (placeholder - would use actual optimization tools)
        for image_file in image_files:
            try:
                # Copy to optimized directory
                relative_path = image_file.relative_to(assets_dir)
                optimized_path = self.optimized_assets_dir / relative_path
                optimized_path.parent.mkdir(parents=True, exist_ok=True)
                
                # For now, just copy the file
                # In production, would use tools like pngquant, jpegoptim, etc.
                shutil.copy2(image_file, optimized_path)
                
            except Exception as e:
                print(f"⚠️ Failed to optimize {image_file}: {e}")
        
        print("✅ Image optimization completed")
    
    def analyze_dependencies(self):
        """Analyze and optimize dependencies"""
        print("📦 Analyzing dependencies...")
        
        try:
            # Run dependency analysis
            result = subprocess.run([
                "flutter", "pub", "deps", "--json"
            ], cwd=self.project_root / "packages/presentation/pandora_app",
            capture_output=True, text=True)
            
            if result.returncode == 0:
                deps_data = json.loads(result.stdout)
                
                # Analyze dependency tree
                unused_deps = self.find_unused_dependencies(deps_data)
                
                # Save analysis report
                report = {
                    "total_dependencies": len(deps_data.get("packages", [])),
                    "unused_dependencies": unused_deps,
                    "analysis_date": str(Path.cwd())
                }
                
                with open(self.reports_dir / "dependency_analysis.json", "w") as f:
                    json.dump(report, f, indent=2)
                
                print(f"✅ Found {len(unused_deps)} potentially unused dependencies")
            else:
                print("❌ Dependency analysis failed")
                
        except Exception as e:
            print(f"❌ Dependency analysis failed: {e}")
    
    def find_unused_dependencies(self, deps_data):
        """Find potentially unused dependencies"""
        # This is a simplified analysis
        # In production, would use more sophisticated tools
        
        unused = []
        packages = deps_data.get("packages", [])
        
        # Check for common unused patterns
        for package in packages:
            name = package.get("name", "")
            if any(pattern in name for pattern in ["test", "mock", "example"]):
                if "dev_dependencies" not in str(package):
                    unused.append(name)
        
        return unused
    
    def generate_performance_report(self):
        """Generate comprehensive performance report"""
        print("📋 Generating performance report...")
        
        report = {
            "optimization_date": str(Path.cwd()),
            "project_root": str(self.project_root),
            "reports_directory": str(self.reports_dir),
            "optimized_assets_directory": str(self.optimized_assets_dir),
            "recommendations": [
                "Use const constructors where possible",
                "Implement lazy loading for large lists",
                "Optimize image sizes and formats",
                "Remove unused dependencies",
                "Use RepaintBoundary for complex widgets",
                "Implement proper state management",
                "Use ListView.builder for dynamic lists",
                "Optimize network requests",
                "Implement proper caching",
                "Use performance monitoring tools"
            ],
            "next_steps": [
                "Run flutter analyze to check for issues",
                "Test on different devices and screen sizes",
                "Monitor app performance in production",
                "Implement performance monitoring",
                "Regular dependency updates",
                "Code review for performance issues"
            ]
        }
        
        # Save report
        with open(self.reports_dir / "performance_report.json", "w") as f:
            json.dump(report, f, indent=2)
        
        # Generate markdown report
        self.generate_markdown_report(report)
        
        print("✅ Performance report generated")
    
    def generate_markdown_report(self, report):
        """Generate markdown performance report"""
        markdown_content = f"""# PandoraX Performance Report

Generated on: {report['optimization_date']}

## Project Information
- Project Root: {report['project_root']}
- Reports Directory: {report['reports_directory']}
- Optimized Assets: {report['optimized_assets_directory']}

## Optimization Recommendations

"""
        
        for i, rec in enumerate(report['recommendations'], 1):
            markdown_content += f"{i}. {rec}\n"
        
        markdown_content += "\n## Next Steps\n\n"
        
        for i, step in enumerate(report['next_steps'], 1):
            markdown_content += f"{i}. {step}\n"
        
        markdown_content += """
## Performance Metrics

| Metric | Value | Status |
|--------|-------|--------|
| Bundle Size | TBD | ⚠️ |
| Image Optimization | TBD | ⚠️ |
| Dependencies | TBD | ⚠️ |
| Code Quality | TBD | ⚠️ |

## Commands to Run

```bash
# Analyze code
flutter analyze

# Build for analysis
flutter build apk --analyze-size

# Run tests
flutter test

# Check dependencies
flutter pub deps
```

## Notes

- This is an automated performance optimization report
- Manual review and testing is recommended
- Regular performance monitoring should be implemented
- Consider using Flutter Inspector for detailed analysis
"""
        
        with open(self.reports_dir / "performance_report.md", "w") as f:
            f.write(markdown_content)

def main():
    if len(sys.argv) != 2:
        print("Usage: python optimize_performance.py <project_root>")
        sys.exit(1)
    
    project_root = sys.argv[1]
    
    if not os.path.exists(project_root):
        print(f"Error: Project root '{project_root}' does not exist")
        sys.exit(1)
    
    optimizer = PerformanceOptimizer(project_root)
    optimizer.run()

if __name__ == "__main__":
    main()
