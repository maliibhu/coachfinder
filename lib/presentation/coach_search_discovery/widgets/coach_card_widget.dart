import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CoachCardWidget extends StatelessWidget {
  final Map<String, dynamic> coach;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onShareTap;

  const CoachCardWidget({
    super.key,
    required this.coach,
    required this.onTap,
    required this.onFavoriteTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.w),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
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
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
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

                          // Sports Tags
                          Wrap(
                            spacing: 2.w,
                            children: (coach["sports"] as List)
                                .map((sport) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 1.w),
                                      decoration: BoxDecoration(
                                        color: AppTheme.lightTheme.primaryColor
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        sport as String,
                                        style: AppTheme
                                            .lightTheme.textTheme.labelSmall
                                            ?.copyWith(
                                          color:
                                              AppTheme.lightTheme.primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Column(
                      children: [
                        GestureDetector(
                          onTap: onFavoriteTap,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            child: CustomIconWidget(
                              iconName: coach["isFavorite"] == true
                                  ? 'favorite'
                                  : 'favorite_border',
                              size: 20,
                              color: coach["isFavorite"] == true
                                  ? Colors.red
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.w),
                        GestureDetector(
                          onTap: onShareTap,
                          child: Container(
                            padding: EdgeInsets.all(2.w),
                            child: CustomIconWidget(
                              iconName: 'share',
                              size: 20,
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 3.w),

                // Experience and Rate Row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'work',
                            size: 16,
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            coach["experienceLevel"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${coach["hourlyRate"]}/hr',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.w),

                // Rating and Distance Row
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'star',
                      size: 16,
                      color: Colors.amber,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      coach["rating"].toString(),
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '(${coach["reviewCount"]})',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    CustomIconWidget(
                      iconName: 'location_on',
                      size: 16,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      coach["distance"] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                ),

                SizedBox(height: 2.w),

                // Availability Status
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
                  decoration: BoxDecoration(
                    color:
                        _getAvailabilityColor(coach["availability"] as String)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 2.w,
                        height: 2.w,
                        decoration: BoxDecoration(
                          color: _getAvailabilityColor(
                              coach["availability"] as String),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        coach["availability"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: _getAvailabilityColor(
                              coach["availability"] as String),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability.toLowerCase()) {
      case 'available today':
        return Colors.green;
      case 'available tomorrow':
        return Colors.blue;
      case 'available this week':
        return Colors.orange;
      case 'busy this week':
        return Colors.red;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }
}
