import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dummy_data.dart';
import 'RestaurantDetailsPage.dart';
import 'restaurant_details_page.dart'; // Import the new page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value.toLowerCase();
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[500],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Discover the best food from nearby restaurants!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                              255, 255, 226, 157), // Use a subtle color accent
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //const SizedBox(height: 10),
            _buildSection(context, 'For You', foodItems),
            const SizedBox(height: 10),
            _buildSection(context, 'Recommended Food', foodItemms),
            const SizedBox(height: 10),
            _buildSection(context, 'Top Rated Food', foodItemmss),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '──────────── Offers ────────────',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Show initial loading dialog
                        return const AlertDialog(
                          content: SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    ).then((_) {
                      // Dismiss initial loading dialog before showing the second dialog
                      Future.delayed(const Duration(seconds: 3), () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Today\'s Special'),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Special Offer: Get 15% Off'),
                                  SizedBox(height: 16),
                                  Text('Coupon Code: RESTO15OFF'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Copy coupon code to clipboard
                                    Clipboard.setData(
                                      const ClipboardData(text: 'RESTO15OFF'),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Copy Coupon Code'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog directly
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    });
                  },
                  child: Image.asset(
                    'assets/images/offert.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                _buildMorphContainer(
                  imageUrl: 'assets/images/deeal.png',
                ),
                _buildMorphContainer(
                  imageUrl: 'assets/images/DISCOUNT.png',
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Copyright © 2024. All Rights Reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildMorphContainer({required String imageUrl}) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Container(
        color: Colors.transparent, // Set background color to light grey
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<FoodItem> items) {
    final filteredItems = _searchQuery.isEmpty
        ? items
        : items
            .where((item) =>
                item.name.toLowerCase().contains(_searchQuery) ||
                item.description.toLowerCase().contains(_searchQuery))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '──────────── $title ────────────',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetailsPage(
                        // Navigate to the new page with restaurant details
                        restaurant:
                            generateDummyRestaurant(), // Pass the selected food item data
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildFoodRow(
                    context,
                    item.name,
                    item.description,
                    item.price,
                    item.rating,
                    item.imagePath,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFoodRow(BuildContext context, String title, String description,
      String price, String rating, String imagePath) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, // Set a finite width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 255, 226, 157),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 255, 226, 157),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: $title",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Price: $price",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Rating: $rating",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Description: $description",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
