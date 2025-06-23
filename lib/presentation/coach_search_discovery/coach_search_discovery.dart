import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/coach_card_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/map_view_widget.dart';
import './widgets/search_header_widget.dart';

class CoachSearchDiscovery extends StatefulWidget {
  const CoachSearchDiscovery({super.key});

  @override
  State<CoachSearchDiscovery> createState() => _CoachSearchDiscoveryState();
}

class _CoachSearchDiscoveryState extends State<CoachSearchDiscovery>
    with TickerProviderStateMixin {
  bool _isMapView = false;
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedLocation = 'Current Location';
  List<String> _activeFilters = [];
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  // Mock data for coaches
  final List<Map<String, dynamic>> _coaches = [
    {
      "id": 1,
      "name": "Sarah Johnson",
      "profileImage":
          "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg",
      "sports": ["Tennis", "Badminton"],
      "experienceLevel": "Professional",
      "hourlyRate": "\$45",
      "rating": 4.8,
      "reviewCount": 127,
      "distance": "0.8 km",
      "isVerified": true,
      "isFavorite": false,
      "availability": "Available Today",
      "location": {"lat": 37.7749, "lng": -122.4194},
      "bio":
          "Professional tennis coach with 8+ years experience training players of all levels."
    },
    {
      "id": 2,
      "name": "Michael Rodriguez",
      "profileImage":
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      "sports": ["Cricket", "Baseball"],
      "experienceLevel": "Expert",
      "hourlyRate": "\$60",
      "rating": 4.9,
      "reviewCount": 89,
      "distance": "1.2 km",
      "isVerified": true,
      "isFavorite": true,
      "availability": "Available Tomorrow",
      "location": {"lat": 37.7849, "lng": -122.4094},
      "bio":
          "Former professional cricket player turned coach, specializing in batting techniques."
    },
    {
      "id": 3,
      "name": "Emma Thompson",
      "profileImage":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg",
      "sports": ["Badminton", "Table Tennis"],
      "experienceLevel": "Intermediate",
      "hourlyRate": "\$35",
      "rating": 4.6,
      "reviewCount": 156,
      "distance": "2.1 km",
      "isVerified": false,
      "isFavorite": false,
      "availability": "Available This Week",
      "location": {"lat": 37.7649, "lng": -122.4294},
      "bio":
          "Enthusiastic badminton coach focusing on technique improvement and fitness."
    },
    {
      "id": 4,
      "name": "David Chen",
      "profileImage":
          "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg",
      "sports": ["Tennis", "Squash"],
      "experienceLevel": "Professional",
      "hourlyRate": "\$55",
      "rating": 4.7,
      "reviewCount": 203,
      "distance": "3.5 km",
      "isVerified": true,
      "isFavorite": false,
      "availability": "Busy This Week",
      "location": {"lat": 37.7549, "lng": -122.4394},
      "bio":
          "Tennis professional with tournament experience, specializing in advanced techniques."
    },
    {
      "id": 5,
      "name": "Lisa Park",
      "profileImage":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg",
      "sports": ["Cricket", "Softball"],
      "experienceLevel": "Expert",
      "hourlyRate": "\$50",
      "rating": 4.5,
      "reviewCount": 94,
      "distance": "4.2 km",
      "isVerified": true,
      "isFavorite": true,
      "availability": "Available Today",
      "location": {"lat": 37.7449, "lng": -122.4494},
      "bio":
          "Cricket coach with focus on youth development and fundamental skills."
    }
  ];

  List<Map<String, dynamic>> _filteredCoaches = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredCoaches = List.from(_coaches);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreCoaches();
    }
  }

  void _loadMoreCoaches() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulate loading more coaches
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filterCoaches();
    });
  }

  void _onLocationChanged(String location) {
    setState(() {
      _selectedLocation = location;
      _filterCoaches();
    });
  }

  void _filterCoaches() {
    setState(() {
      _filteredCoaches = _coaches.where((coach) {
        bool matchesSearch = _searchQuery.isEmpty ||
            (coach["name"] as String)
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            (coach["sports"] as List).any((sport) =>
                sport.toLowerCase().contains(_searchQuery.toLowerCase()));

        return matchesSearch;
      }).toList();
    });
  }

  void _toggleFavorite(int coachId) {
    setState(() {
      final coachIndex =
          _filteredCoaches.indexWhere((coach) => coach["id"] == coachId);
      if (coachIndex != -1) {
        _filteredCoaches[coachIndex]["isFavorite"] =
            !_filteredCoaches[coachIndex]["isFavorite"];
      }
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheetWidget(
        activeFilters: _activeFilters,
        onFiltersApplied: (filters) {
          setState(() {
            _activeFilters = filters;
            _filterCoaches();
          });
        },
      ),
    );
  }

  void _removeFilter(String filter) {
    setState(() {
      _activeFilters.remove(filter);
      _filterCoaches();
    });
  }

  Future<void> _refreshCoaches() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _filteredCoaches = List.from(_coaches);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Find Coaches',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isMapView = !_isMapView;
              });
            },
            icon: CustomIconWidget(
              iconName: _isMapView ? 'list' : 'map',
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Header
          SearchHeaderWidget(
            searchQuery: _searchQuery,
            selectedLocation: _selectedLocation,
            activeFiltersCount: _activeFilters.length,
            onSearchChanged: _onSearchChanged,
            onLocationChanged: _onLocationChanged,
            onFilterTapped: _showFilterBottomSheet,
          ),

          // Active Filters Chips
          if (_activeFilters.isNotEmpty)
            Container(
              height: 6.h,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _activeFilters.length,
                itemBuilder: (context, index) {
                  final filter = _activeFilters[index];
                  return Container(
                    margin: EdgeInsets.only(right: 2.w),
                    child: Chip(
                      label: Text(
                        filter,
                        style: AppTheme.lightTheme.textTheme.labelMedium,
                      ),
                      deleteIcon: CustomIconWidget(
                        iconName: 'close',
                        size: 16,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                      onDeleted: () => _removeFilter(filter),
                      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                    ),
                  );
                },
              ),
            ),

          // Content Area
          Expanded(
            child: _isMapView
                ? MapViewWidget(
                    coaches: _filteredCoaches,
                    onCoachTapped: (coachId) {
                      Navigator.pushNamed(context, '/coach-profile-detail');
                    },
                  )
                : RefreshIndicator(
                    onRefresh: _refreshCoaches,
                    color: AppTheme.lightTheme.primaryColor,
                    child: _filteredCoaches.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.all(4.w),
                            itemCount:
                                _filteredCoaches.length + (_isLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == _filteredCoaches.length) {
                                return _buildLoadingIndicator();
                              }

                              final coach = _filteredCoaches[index];
                              return CoachCardWidget(
                                coach: coach,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/coach-profile-detail');
                                },
                                onFavoriteTap: () =>
                                    _toggleFavorite(coach["id"]),
                                onShareTap: () {
                                  // Implement share functionality
                                },
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search_off',
            size: 64,
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 2.h),
          Text(
            'No coaches found',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          Text(
            'Try adjusting your search or filters',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _activeFilters.clear();
                _filterCoaches();
              });
            },
            child: Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Center(
        child: CircularProgressIndicator(
          color: AppTheme.lightTheme.primaryColor,
        ),
      ),
    );
  }
}
