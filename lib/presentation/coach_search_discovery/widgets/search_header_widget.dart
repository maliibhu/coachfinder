import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchHeaderWidget extends StatelessWidget {
  final String searchQuery;
  final String selectedLocation;
  final int activeFiltersCount;
  final Function(String) onSearchChanged;
  final Function(String) onLocationChanged;
  final VoidCallback onFilterTapped;

  const SearchHeaderWidget({
    super.key,
    required this.searchQuery,
    required this.selectedLocation,
    required this.activeFiltersCount,
    required this.onSearchChanged,
    required this.onLocationChanged,
    required this.onFilterTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline,
                    ),
                  ),
                  child: TextField(
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search coaches or sports...',
                      hintStyle:
                          AppTheme.lightTheme.inputDecorationTheme.hintStyle,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'search',
                          size: 20,
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 3.w,
                      ),
                    ),
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              // Filter Button
              GestureDetector(
                onTap: onFilterTapped,
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: activeFiltersCount > 0
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: activeFiltersCount > 0
                          ? AppTheme.lightTheme.primaryColor
                          : AppTheme.lightTheme.colorScheme.outline,
                    ),
                  ),
                  child: Stack(
                    children: [
                      CustomIconWidget(
                        iconName: 'tune',
                        size: 24,
                        color: activeFiltersCount > 0
                            ? AppTheme.lightTheme.colorScheme.onPrimary
                            : AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                      if (activeFiltersCount > 0)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.tertiary,
                              shape: BoxShape.circle,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 4.w,
                              minHeight: 4.w,
                            ),
                            child: Text(
                              activeFiltersCount.toString(),
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color:
                                    AppTheme.lightTheme.colorScheme.onTertiary,
                                fontSize: 8.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.w),

          // Location Selector
          GestureDetector(
            onTap: () => _showLocationPicker(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'location_on',
                    size: 20,
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      selectedLocation,
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'keyboard_arrow_down',
                    size: 20,
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationPicker(BuildContext context) {
    final locations = [
      'Current Location',
      'Downtown',
      'Sports Complex',
      'University Area',
      'City Center',
      'Suburbs',
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Location',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            SizedBox(height: 3.w),
            ...locations.map((location) => ListTile(
                  leading: CustomIconWidget(
                    iconName: location == 'Current Location'
                        ? 'my_location'
                        : 'location_on',
                    size: 20,
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                  title: Text(
                    location,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                  trailing: selectedLocation == location
                      ? CustomIconWidget(
                          iconName: 'check',
                          size: 20,
                          color: AppTheme.lightTheme.primaryColor,
                        )
                      : null,
                  onTap: () {
                    onLocationChanged(location);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
