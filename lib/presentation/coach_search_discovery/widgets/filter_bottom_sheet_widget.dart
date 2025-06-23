import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final List<String> activeFilters;
  final Function(List<String>) onFiltersApplied;

  const FilterBottomSheetWidget({
    super.key,
    required this.activeFilters,
    required this.onFiltersApplied,
  });

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  List<String> _selectedSports = [];
  String _selectedExperience = '';
  RangeValues _priceRange = const RangeValues(20, 80);
  final List<String> _selectedAvailability = [];
  double _minRating = 4.0;
  double _maxDistance = 10.0;

  final List<String> _sports = [
    'Tennis',
    'Badminton',
    'Cricket',
    'Baseball',
    'Table Tennis',
    'Squash',
    'Softball',
  ];

  final List<String> _experienceLevels = [
    'Beginner',
    'Intermediate',
    'Professional',
    'Expert',
  ];

  final List<String> _availabilityOptions = [
    'Available Today',
    'Available Tomorrow',
    'Available This Week',
    'Weekends Only',
    'Evenings Only',
  ];

  @override
  void initState() {
    super.initState();
    _initializeFilters();
  }

  void _initializeFilters() {
    // Initialize filters based on active filters
    // This is a simplified implementation
    _selectedSports = _sports
        .where((sport) =>
            widget.activeFilters.any((filter) => filter.contains(sport)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle Bar
          Container(
            margin: EdgeInsets.only(top: 2.w),
            width: 12.w,
            height: 1.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Text(
                  'Filters',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: Text(
                    'Clear All',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.lightTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filter Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSportTypeFilter(),
                  SizedBox(height: 4.w),
                  _buildExperienceLevelFilter(),
                  SizedBox(height: 4.w),
                  _buildPriceRangeFilter(),
                  SizedBox(height: 4.w),
                  _buildAvailabilityFilter(),
                  SizedBox(height: 4.w),
                  _buildRatingFilter(),
                  SizedBox(height: 4.w),
                  _buildDistanceFilter(),
                  SizedBox(height: 8.w),
                ],
              ),
            ),
          ),

          // Apply Button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                child: Text('Apply Filters'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportTypeFilter() {
    return _buildFilterSection(
      title: 'Sport Type',
      child: Wrap(
        spacing: 2.w,
        runSpacing: 2.w,
        children: _sports
            .map((sport) => FilterChip(
                  label: Text(sport),
                  selected: _selectedSports.contains(sport),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedSports.add(sport);
                      } else {
                        _selectedSports.remove(sport);
                      }
                    });
                  },
                  selectedColor:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.lightTheme.primaryColor,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildExperienceLevelFilter() {
    return _buildFilterSection(
      title: 'Experience Level',
      child: Column(
        children: _experienceLevels
            .map((level) => RadioListTile<String>(
                  title: Text(level),
                  value: level,
                  groupValue: _selectedExperience,
                  onChanged: (value) {
                    setState(() {
                      _selectedExperience = value ?? '';
                    });
                  },
                  activeColor: AppTheme.lightTheme.primaryColor,
                  contentPadding: EdgeInsets.zero,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPriceRangeFilter() {
    return _buildFilterSection(
      title:
          'Price Range (\$${_priceRange.start.round()}/hr - \$${_priceRange.end.round()}/hr)',
      child: RangeSlider(
        values: _priceRange,
        min: 10,
        max: 100,
        divisions: 18,
        labels: RangeLabels(
          '\$${_priceRange.start.round()}',
          '\$${_priceRange.end.round()}',
        ),
        onChanged: (values) {
          setState(() {
            _priceRange = values;
          });
        },
        activeColor: AppTheme.lightTheme.primaryColor,
      ),
    );
  }

  Widget _buildAvailabilityFilter() {
    return _buildFilterSection(
      title: 'Availability',
      child: Column(
        children: _availabilityOptions
            .map((option) => CheckboxListTile(
                  title: Text(option),
                  value: _selectedAvailability.contains(option),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        _selectedAvailability.add(option);
                      } else {
                        _selectedAvailability.remove(option);
                      }
                    });
                  },
                  activeColor: AppTheme.lightTheme.primaryColor,
                  contentPadding: EdgeInsets.zero,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildRatingFilter() {
    return _buildFilterSection(
      title: 'Minimum Rating (${_minRating.toStringAsFixed(1)} stars)',
      child: Slider(
        value: _minRating,
        min: 1.0,
        max: 5.0,
        divisions: 8,
        label: '${_minRating.toStringAsFixed(1)} stars',
        onChanged: (value) {
          setState(() {
            _minRating = value;
          });
        },
        activeColor: AppTheme.lightTheme.primaryColor,
      ),
    );
  }

  Widget _buildDistanceFilter() {
    return _buildFilterSection(
      title: 'Maximum Distance (${_maxDistance.toStringAsFixed(1)} km)',
      child: Slider(
        value: _maxDistance,
        min: 1.0,
        max: 50.0,
        divisions: 49,
        label: '${_maxDistance.toStringAsFixed(1)} km',
        onChanged: (value) {
          setState(() {
            _maxDistance = value;
          });
        },
        activeColor: AppTheme.lightTheme.primaryColor,
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.w),
        child,
      ],
    );
  }

  void _clearAllFilters() {
    setState(() {
      _selectedSports.clear();
      _selectedExperience = '';
      _priceRange = const RangeValues(20, 80);
      _selectedAvailability.clear();
      _minRating = 4.0;
      _maxDistance = 10.0;
    });
  }

  void _applyFilters() {
    List<String> filters = [];

    // Add selected sports
    filters.addAll(_selectedSports);

    // Add experience level
    if (_selectedExperience.isNotEmpty) {
      filters.add(_selectedExperience);
    }

    // Add price range
    filters.add(
        'Price: \$${_priceRange.start.round()}-\$${_priceRange.end.round()}');

    // Add availability
    filters.addAll(_selectedAvailability);

    // Add rating
    if (_minRating > 1.0) {
      filters.add('Rating: ${_minRating.toStringAsFixed(1)}+ stars');
    }

    // Add distance
    if (_maxDistance < 50.0) {
      filters.add('Distance: ${_maxDistance.toStringAsFixed(1)} km');
    }

    widget.onFiltersApplied(filters);
    Navigator.pop(context);
  }
}
