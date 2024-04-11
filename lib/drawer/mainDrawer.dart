// MyDrawer.dart

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:restoapp/drawer/cart.dart';
import 'homePage.dart';
import 'aboutUs.dart';
import 'settingsPage.dart';
import 'profilePage.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pageController = PageController();
  String _currentLocation = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(context);
  }

  Future<void> _getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      // Handle disabled location services here, like showing a dialog to enable it.
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Handle the case where the user has permanently denied permission
        // You might want to show a dialog here to inform the user about the necessity of location services for your app.
        return;
      }

      if (permission == LocationPermission.denied) {
        // Handle the case where the user denied the permission
        // You might want to show a dialog here to inform the user about the necessity of location services for your app.
        return;
      }
    }

    // Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String? city = placemark.locality;
        String? state = placemark.administrativeArea;

        setState(() {
          _currentLocation = '${city ?? 'Unknown'}, ${state ?? 'Unknown'}';
        });
      } else {
        setState(() {
          _currentLocation = 'Unknown';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _currentLocation = 'Unable to fetch location';
      });
    }
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      // Handle permission denied
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('        Foodzii App\n$_currentLocation'),
          backgroundColor: const Color.fromARGB(255, 255, 226, 157),
          foregroundColor: Colors.black,
          toolbarHeight: 60,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                print('Logout button pressed');
              },
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // Disable swiping
          controller: _pageController,
          children: const <Widget>[
            HomePage(),
            ProfilePage(),
            CartPage(),
            SettingPage(),
            AboutUs(),
          ],
        ),
        drawer: CurvedDrawer(
          color: const Color.fromARGB(255, 255, 240, 219),
          buttonBackgroundColor: Colors.lightGreenAccent,
          labelColor: Colors.red,
          backgroundColor: Colors.transparent,
          width: 75.0,
          items: const <DrawerItem>[
            DrawerItem(icon: Icon(Icons.home), label: "Home"),
            DrawerItem(icon: Icon(Icons.person), label: "Profile"),
            DrawerItem(icon: Icon(Icons.call_to_action_rounded), label: "Cart"),
            DrawerItem(icon: Icon(Icons.settings), label: "Settings"),
            DrawerItem(
                icon: Icon(Icons.app_shortcut_rounded), label: "About us"),
          ],
          onTap: (index) {
            print('Button Pressed');
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
