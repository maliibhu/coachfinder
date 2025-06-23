import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CoachReviewsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> reviews;
  final double rating;
  final int reviewCount;

  const CoachReviewsWidget({
    super.key,
    required this.reviews,
    required this.rating,
    required this.reviewCount,
  });

  @override
  State<CoachReviewsWidget> createState() => _CoachReviewsWidgetState();
}

class _CoachReviewsWidgetState extends State<CoachReviewsWidget> {
  final Set<int> _expandedReviews = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: _viewAllReviews,
                child: Text(
                  'View All',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          // Rating summary
          Row(
            children: [
              CustomIconWidget(
                iconName: 'star',
                color: AppTheme.getWarningColor(true),
                size: 24,
              ),
              SizedBox(width: 2.w),
              Text(
                '${widget.rating}',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                '(${widget.reviewCount} reviews)',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Reviews list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.reviews.length > 3 ? 3 : widget.reviews.length,
            separatorBuilder: (context, index) => Divider(
              height: 3.h,
              color: AppTheme.lightTheme.colorScheme.outline,
            ),
            itemBuilder: (context, index) {
              final review = widget.reviews[index];
              final reviewId = review["id"] as int;
              final isExpanded = _expandedReviews.contains(reviewId);
              final comment = review["comment"] as String;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reviewer info and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review["reviewer"] as String,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              review["date"] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: List.generate(5, (starIndex) {
                          return CustomIconWidget(
                            iconName: starIndex < (review["rating"] as int)
                                ? 'star'
                                : 'star_border',
                            color: AppTheme.getWarningColor(true),
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  // Review comment
                  Text(
                    isExpanded || comment.length <= 100
                        ? comment
                        : '${comment.substring(0, 100)}...',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      height: 1.5,
                    ),
                  ),
                  if (comment.length > 100)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isExpanded) {
                            _expandedReviews.remove(reviewId);
                          } else {
                            _expandedReviews.add(reviewId);
                          }
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.5.h),
                        child: Text(
                          isExpanded ? 'Show less' : 'Read more',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _viewAllReviews() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening all reviews...'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }
}
