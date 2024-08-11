import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vivasayi/main.dart';

class ShopsProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> addShop(
    XFile? image,
    String shopName,
    String phone,
    String whatsapp,
    List<dynamic> shopCategory,
    dynamic data,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      String fileName = image!.name;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('shops/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(image.path));

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // List<Location> locations = await locationFromAddress(address);
      // // if (locations.isNotEmpty) {
      // Location first = locations.first;

      // print(first.latitude);
      // print(first.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          data.latLong.latitude, data.latLong.longitude);
      String city = placemarks.reversed.last.locality ?? '';
      String id = DateTime.now().toString();

      await FirebaseFirestore.instance.collection('shops_new').doc(id).set({
        'id': id,
        'image_url': downloadURL,
        'shopName': shopName,
        'phone': phone,
        'whatsapp': whatsapp,
        'shopCategory': shopCategory,
        'address': data.address,
        'latitude': data.latLong.latitude,
        'longitude': data.latLong.longitude,
        'city': city
        // Add other fields as needed
      });
      // } else {
      // throw Exception('Failed to fetch coordinates for the address.');
      // }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error adding shop: $e');
      // Handle error (show error message, retry logic, etc.)
      _isLoading = false;
      notifyListeners();
    }
  }

  //===========UPDADTE SHOP ==================

  Future<void> updateShop(
      String image,
      String shopName,
      String phone,
      String whatsapp,
      List<dynamic> shopCategory,
      dynamic data,
      double lat,
      double long,
      String id,
      String address) async {
    try {
      _isLoading = true;
      notifyListeners();
      print(data);

      // String fileName = image!.name;
      // Reference storageRef =
      //     FirebaseStorage.instance.ref().child('shops/$fileName');
      // UploadTask uploadTask = storageRef.putFile(File(image.path));

      // TaskSnapshot taskSnapshot = await uploadTask;
      // String downloadURL = await taskSnapshot.ref.getDownloadURL();

      // List<Location> locations = await locationFromAddress(address);
      // // if (locations.isNotEmpty) {
      // Location first = locations.first;

      // print(first.latitude);
      // print(first.longitude);
      double lati = data != null ? data.latLong.latitude : lat;
      double longi = data != null ? data.latLong.longitude : long;

      List<Placemark> placemarks = await placemarkFromCoordinates(lati, longi);
      String city = placemarks.reversed.last.locality ?? '';

      await FirebaseFirestore.instance.collection('shops_new').doc(id).update({
        'id': id,
        'image_url': image,
        'shopName': shopName,
        'phone': phone,
        'whatsapp': whatsapp,
        'shopCategory': shopCategory,
        'address': data != null ? data.address : address,
        'latitude': lati,
        'longitude': longi,
        'city': city
        // Add other fields as needed
      });
      // } else {
      // throw Exception('Failed to fetch coordinates for the address.');
      // }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error adding shop: $e');
      // Handle error (show error message, retry logic, etc.)
      _isLoading = false;
      notifyListeners();
    }
  }

  //fetch Shops
  List<dynamic> _shopList = [];
  List<dynamic> get shopList => _shopList;
  Future<void> fetchShops(String shopCategory) async {
    _shopList.clear();
    _isLoading = true;
    notifyListeners();

    try {
      double userLatitude = position.latitude;
      double userLongitude = position.longitude;

      List<dynamic> data;
      FirebaseFirestore.instance
          .collection('shops_new')
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        data = snapshot.docs.map((doc) => doc.data()).toList();

        for (var shop in data) {
          for (var category in shop['shopCategory']) {
            if (category == shopCategory) {
              double shopLatitude = shop['latitude'];
              double shopLongitude = shop['longitude'];

              double distanceInMeters = Geolocator.distanceBetween(
                userLatitude,
                userLongitude,
                shopLatitude,
                shopLongitude,
              );

              double distanceInKilometers = distanceInMeters / 1000;

              if (distanceInKilometers <= 100) {
                _shopList.add(shop);
              }
            }
          }
        }
        notifyListeners();
      });
    } catch (e) {
      print('Error fetching shops: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue
    return await Geolocator.getCurrentPosition();
  }

  //=========== Add Products ==========================
  Future<void> addProducts(
      String name,
      String qty,
      String price,
      String description,
      XFile? image,
      String shopCategory,
      String shopName) async {
    _isLoading = true;
    notifyListeners();

    String fileName = image!.name;
    Reference storageRef =
        FirebaseStorage.instance.ref().child('products/$fileName');
    UploadTask uploadTask = storageRef.putFile(File(image.path));

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    String id = DateTime.now().toString();

    await FirebaseFirestore.instance.collection('products_new').doc(id).set({
      'id' : id,
      'image_url': downloadURL,
      'productName': name, // Replace with your actual data
      'qty': qty,
      // 'unit': unit,
      'shopCategory': shopCategory,
      'shopName': shopName,
      'price': price,
      'description': description
      // Replace with your actual data
      // Add other fields as needed
    });
    _isLoading = false;
    notifyListeners();
  }


  //===========edit products==========
  //=========== Add Products ==========================
  Future<void> updateProducts(
      String name,
      String qty,
      String price,
      String description,
      String image,
      String shopCategory,
      String shopName , String id) async {
    _isLoading = true;
    notifyListeners();

    // String fileName = image!.name;
    // Reference storageRef =
    //     FirebaseStorage.instance.ref().child('products/$fileName');
    // UploadTask uploadTask = storageRef.putFile(File(image.path));

    // TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    // String downloadURL = await taskSnapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('products_new').doc(id).update({
      'id' : id,
      'image_url': image,
      'productName': name, // Replace with your actual data
      'qty': qty,
      // 'unit': unit,
      'shopCategory': shopCategory,
      'shopName': shopName,
      'price': price,
      'description': description
      // Replace with your actual data
      // Add other fields as needed
    });
    _isLoading = false;
    notifyListeners();
  }

  //===========FETCH PRODUCTS =====================

  List<dynamic> _productList = [];
  List<dynamic> get productList => _productList;

  Future<void> fetchProducts(String shopName) async {
    _productList.clear();
    _isLoading = true;
    notifyListeners();

    FirebaseFirestore.instance
        .collection('products_new')
        .where('shopName', isEqualTo: shopName)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      _productList = snapshot.docs.map((doc) => doc.data()).toList();

      notifyListeners();
    });

    _isLoading = false;
    notifyListeners();
  }

  //==============delete particular product =================

  Future<void> deleteShop(String name) async {
    _isLoading = true;
    notifyListeners();
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('shops_new')
          .where('shopName', isEqualTo: name)
          .get();

      for (var doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection('shops_new')
            .doc(doc.id)
            .delete();
      }

      // Refresh the product list after deletion
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  //==============delete particular product =================

  Future<void> deleteProduct(String name) async {
    _isLoading = true;
    notifyListeners();
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('products_new')
          .where('productName', isEqualTo: name)
          .get();

      for (var doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection('products_new')
            .doc(doc.id)
            .delete();
      }

      // Refresh the product list after deletion
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
