import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:vivasayi/core/app_imports.dart';

class HomeProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeProvider(){
    fetchBanner();
  }

  // =========== add Banner =============
  Future<void> addBanner(Uint8List bytes, String name) async {
    _isLoading = true;
    notifyListeners();

    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('banner')
        .child(name);
    await ref.putData(bytes);

    // Get download URL from Firebase Storage
    String downloadURL = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('banner_new').add({
      'image_url': downloadURL,
      // Replace with your actual data
      // Add other fields as needed
    });
    _isLoading = false;
    notifyListeners();
  }


  //==========fetch banner ===============
  List<dynamic> _bannerList = [];
  List<dynamic> get bannerList => _bannerList;


  Future<void> fetchBanner() async{
     _bannerList.clear();
    _isLoading = true;
    notifyListeners();

    List<dynamic> data;
    FirebaseFirestore.instance
        .collection('banner_new')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      _bannerList = snapshot.docs.map((doc) => doc.data()).toList();

      
      
      notifyListeners();
    });

    _isLoading = false;
    notifyListeners();

  }
}
