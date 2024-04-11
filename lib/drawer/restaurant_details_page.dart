// Define the classes for Restaurant, MenuItem, and Review
import 'dart:math';

class Restaurant {
  final String name;
  final String address;
  final List<MenuItem> menu;
  final List<String> photos;
  final List<Review> reviews;
  final String contact;

  Restaurant({
    required this.name,
    required this.address,
    required this.menu,
    required this.photos,
    required this.reviews,
    required this.contact,
  });
}

class MenuItem {
  final String name;
  final String description;
  final double price;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
  });
}

class Review {
  final String username;
  final String comment;
  final double rating;

  Review({
    required this.username,
    required this.comment,
    required this.rating,
  });
}

// Function to generate dummy data for a restaurant
Restaurant generateDummyRestaurant() {
  final random = Random();

  final List<MenuItem> menu = [
    MenuItem(
        name: 'Spaghetti Carbonari',
        description: 'Pasta with bacon, eggs, and cheese',
        price: 12.99),
    MenuItem(
        name: 'Margherita Pizza',
        description: 'Pizza with tomato, mozzarella, and basil',
        price: 10.99),
    MenuItem(
        name: 'Grilled Chicken Salad',
        description: 'Mixed greens with grilled chicken',
        price: 8.99),
    MenuItem(
        name: 'Cheeseburger',
        description: 'Beef patty with cheese, lettuce, and tomato',
        price: 9.99),
  ];

  final List<String> photos = [
    'assets/images/restaurant_photo1.jpg',
    'assets/images/restaurant_photo2.jpg',
    'assets/images/restaurant_photo3.jpg',
  ];

  final List<Review> reviews = [
    Review(
        username: 'JohnDoe', comment: 'Great food and service!', rating: 4.5),
    Review(
        username: 'JaneSmith',
        comment: 'Average food, but nice ambiance.',
        rating: 3.0),
    Review(
        username: 'AliceWonder',
        comment: 'Best restaurant in town!',
        rating: 5.0),
  ];

  const String address = 'Nagpur, Maharashtra';
  const String contact = '+91 1234567890';

  return Restaurant(
    name: 'Restaurant ${random.nextInt(100)}',
    address: address,
    menu: menu,
    photos: photos,
    reviews: reviews,
    contact: contact,
  );
}
