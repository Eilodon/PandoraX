import 'package:flutter/material.dart';

/// Memory Search Bar Widget
/// 
/// Provides search functionality for memories with advanced filters
class MemorySearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearchChanged;
  final bool showAdvancedFilters;
  final VoidCallback? onAdvancedFiltersPressed;

  const MemorySearchBar({
    super.key,
    required this.controller,
    required this.onSearchChanged,
    this.showAdvancedFilters = false,
    this.onAdvancedFiltersPressed,
  });

  @override
  State<MemorySearchBar> createState() => _MemorySearchBarState();
}

class _MemorySearchBarState extends State<MemorySearchBar> {
  bool _isSearching = false;
  String _selectedMemoryType = 'All';
  String _selectedSource = 'All';
  String _selectedTimeRange = 'All Time';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Main search bar
        Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            onChanged: (value) {
              setState(() {
                _isSearching = value.isNotEmpty;
              });
              widget.onSearchChanged(value);
            },
            decoration: InputDecoration(
              hintText: 'Search memories...',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: _isSearching ? theme.primaryColor : Colors.grey[500],
              ),
              suffixIcon: _buildSuffixIcon(),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        
        // Advanced filters (if enabled)
        if (widget.showAdvancedFilters) ...[
          const SizedBox(height: 12),
          _buildAdvancedFilters(),
        ],
      ],
    );
  }

  Widget _buildSuffixIcon() {
    if (widget.controller.text.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.controller.clear();
              setState(() {
                _isSearching = false;
              });
              widget.onSearchChanged('');
            },
            tooltip: 'Clear search',
          ),
          if (widget.showAdvancedFilters)
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: widget.onAdvancedFiltersPressed,
              tooltip: 'Advanced filters',
            ),
        ],
      );
    }
    
    if (widget.showAdvancedFilters) {
      return IconButton(
        icon: const Icon(Icons.tune),
        onPressed: widget.onAdvancedFiltersPressed,
        tooltip: 'Advanced filters',
      );
    }
    
    return const SizedBox.shrink();
  }

  Widget _buildAdvancedFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Advanced Filters',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMemoryTypeFilter(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSourceFilter(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTimeRangeFilter(),
        ],
      ),
    );
  }

  Widget _buildMemoryTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Memory Type',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _selectedMemoryType,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: const [
            DropdownMenuItem(value: 'All', child: Text('All Types')),
            DropdownMenuItem(value: 'Explicit', child: Text('Explicit')),
            DropdownMenuItem(value: 'Implicit', child: Text('Implicit')),
            DropdownMenuItem(value: 'Emotional', child: Text('Emotional')),
            DropdownMenuItem(value: 'Temporal', child: Text('Temporal')),
            DropdownMenuItem(value: 'Spatial', child: Text('Spatial')),
            DropdownMenuItem(value: 'Social', child: Text('Social')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedMemoryType = value ?? 'All';
            });
          },
        ),
      ],
    );
  }

  Widget _buildSourceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Source',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _selectedSource,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: const [
            DropdownMenuItem(value: 'All', child: Text('All Sources')),
            DropdownMenuItem(value: 'notes', child: Text('Notes')),
            DropdownMenuItem(value: 'ai_response', child: Text('AI Responses')),
            DropdownMenuItem(value: 'ai_chat', child: Text('AI Chat')),
            DropdownMenuItem(value: 'user_feedback', child: Text('User Feedback')),
            DropdownMenuItem(value: 'learning', child: Text('Learning')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedSource = value ?? 'All';
            });
          },
        ),
      ],
    );
  }

  Widget _buildTimeRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time Range',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _selectedTimeRange,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: const [
            DropdownMenuItem(value: 'All Time', child: Text('All Time')),
            DropdownMenuItem(value: 'Today', child: Text('Today')),
            DropdownMenuItem(value: 'Yesterday', child: Text('Yesterday')),
            DropdownMenuItem(value: 'Last 7 days', child: Text('Last 7 days')),
            DropdownMenuItem(value: 'Last 30 days', child: Text('Last 30 days')),
            DropdownMenuItem(value: 'Last 3 months', child: Text('Last 3 months')),
            DropdownMenuItem(value: 'Last year', child: Text('Last year')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedTimeRange = value ?? 'All Time';
            });
          },
        ),
      ],
    );
  }
}
