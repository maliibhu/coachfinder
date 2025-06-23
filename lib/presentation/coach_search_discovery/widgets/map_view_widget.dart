import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class MapViewWidget extends StatefulWidget {
  final List<Map<String, dynamic>> coaches;
  final Function(int) onCoachTapped;

  const MapViewWidget({
    super.key,
    required this.coaches,
    required this.onCoachTapped,
  });

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  Map<String, dynamic>? _selectedCoach;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Placeholder (In a real app, this would be Google Maps or Apple Maps)
        Container(
          width: double.infinity,
          height: double.infinity,
          color: AppTheme.lightTheme.colorScheme.surface,
          child: Stack(
            children: [
              // Map Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                      AppTheme.lightTheme.colorScheme.surface,
                    ],
                  ),
                ),
              ),

              // Coach Markers
              ...widget.coaches.asMap().entries.map((entry) {
                final index = entry.key;
                final coach = entry.value;
                final location = coach["location"] as Map<String, dynamic>;

                // Calculate position based on index (mock positioning)
                final left = (20 + (index * 15) % 60).toDouble();
                final top = (20 + (index * 20) % 50).toDouble();

                return Positioned(
                  left: left.w,
                  top: top.h,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCoach = coach;
                      });
                    },
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: _selectedCoach?["id"] == coach["id"]
                            ? AppTheme.lightTheme.colorScheme.tertiary
                            : AppTheme.lightTheme.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.lightTheme.colorScheme.shadow,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CustomImageWidget(
                          imageUrl: coach["profileImage"] as String,
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Map Controls
              Positioned(
                right: 4.w,
                top: 4.w,
                child: Column(
                  children: [
                    _buildMapControl(
                      icon: 'my_location',
                      onTap: () {
                        // Center on user location
                      },
                    ),
                    SizedBox(height: 2.w),
                    _buildMapControl(
                      icon: 'zoom_in',
                      onTap: () {
                        // Zoom in
                      },
                    ),
                    SizedBox(height: 2.w),
                    _buildMapControl(
                      icon: 'zoom_out',
                      onTap: () {
                        // Zoom out
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Coach Preview Card
        if (_selectedCoach != null)
          Positioned(
            bottom: 4.w,
            left: 4.w,
            right: 4.w,
            child: _buildCoachPreviewCard(_selectedCoach!),
          ),
      ],
    );
  }

  Widget _buildMapControl({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: icon,
            size: 20,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildCoachPreviewCard(Map<String, dynamic> coach) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Profile Image
                Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: CustomImageWidget(
                      imageUrl: coach["profileImage"] as String,
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 4.w),

                // Coach Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              coach["name"] as String,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (coach["isVerified"] == true)
                            Container(
                              margin: EdgeInsets.only(left: 2.w),
                              child: CustomIconWidget(
                                iconName: 'verified',
                                size: 16,
                                color: AppTheme.lightTheme.primaryColor,
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 1.w),

                      // Rating and Distance
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            size: 14,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            coach["rating"].toString(),
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          CustomIconWidget(
                            iconName: 'location_on',
                            size: 14,
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            coach["distance"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Close Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCoach = null;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    child: CustomIconWidget(
                      iconName: 'close',
                      size: 20,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 3.w),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onCoachTapped(coach["id"]);
                    },
                    child: Text('View Profile'),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Quick book functionality
                    },
                    child: Text('Book Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
