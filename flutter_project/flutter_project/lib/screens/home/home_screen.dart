import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_marketplace/providers/car_provider.dart';
import 'package:car_marketplace/widgets/car_card.dart';
import 'package:car_marketplace/widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _selectedType = 'all';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCars() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final carProvider = Provider.of<CarProvider>(context, listen: false);
      await carProvider.fetchCars(
        type: _selectedType == 'all' ? null : _selectedType,
        search: _searchController.text.isEmpty ? null : _searchController.text,
      );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _filterByType(String type) {
    setState(() {
      _selectedType = type;
    });
    _loadCars();
  }

  void _search() {
    _loadCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوق السيارات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigate to notifications screen
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'مرحباً بك',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'اسم المستخدم',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('الرئيسية'),
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('المحفظة'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/wallet');
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_membership),
              title: const Text('الاشتراكات'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/subscription');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('الملف الشخصي'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/profile');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('تسجيل الخروج'),
              onTap: () {
                Navigator.pop(context);
                // Implement logout functionality
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن سيارة...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _search();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onSubmitted: (_) => _search(),
                ),
                const SizedBox(height: 16),
                // Filter buttons
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('الكل'),
                        selected: _selectedType == 'all',
                        onSelected: (_) => _filterByType('all'),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('بيع'),
                        selected: _selectedType == 'sale',
                        onSelected: (_) => _filterByType('sale'),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('تأجير'),
                        selected: _selectedType == 'rent',
                        onSelected: (_) => _filterByType('rent'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Car list
          Expanded(
            child: _isLoading
                ? const Center(child: LoadingIndicator())
                : Consumer<CarProvider>(
                    builder: (context, carProvider, child) {
                      final cars = carProvider.cars;
                      
                      if (cars.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.car_rental,
                                size: 80,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'لا توجد سيارات متاحة',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      
                      return RefreshIndicator(
                        onRefresh: _loadCars,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: cars.length,
                          itemBuilder: (context, index) {
                            final car = cars[index];
                            return CarCard(
                              car: car,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/car-detail',
                                  arguments: {'carId': car.id},
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-car');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
