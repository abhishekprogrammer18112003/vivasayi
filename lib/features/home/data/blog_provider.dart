import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vivasayi/core/loaded_widget.dart';

class BlogProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> createBlog(
    // The ID of the document to be created
    List<XFile> images,
    String heading,
    String title,
    String description,
  ) async {
    _isLoading = true;
    notifyListeners();

    List<String> imageUrls = [];

    // Upload each image and get its URL
    for (var image in images) {
      String fileName = image.name;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('${heading}/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(image.path));

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      imageUrls.add(downloadURL);
    }
    String documentId = DateTime.now().toString();

    // Create a new document with a specific ID in Firestore
    await FirebaseFirestore.instance.collection(heading).doc(documentId).set({
      'id': documentId,
      'image_url': imageUrls,
      'title': title,
      'description': description,
    });

    _isLoading = false;
    notifyListeners();
  }

  // =================== FETCH BLOG PROVIDERS =====================

  List<dynamic> _blogList = [];
  List<dynamic> get blogList => _blogList;
  bool _isLoadingBlog = false;
  bool get isLoadingBlog => _isLoadingBlog;
  Future<void> getBlogList(String title) async {
    _isLoadingBlog = true;
    notifyListeners();

    FirebaseFirestore.instance
        .collection(title)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      _blogList = snapshot.docs.map((doc) => doc.data()).toList();
      notifyListeners();
    });

    _isLoadingBlog = false;
    notifyListeners();
  }

  Future<void> updateBlog(List<dynamic> image, String heading, String title,
      String description, String documentId) async {
    _isLoading = true;
    notifyListeners();

    // List<String> url = [];
    // for (var image in _images) {
    //   String fileName = image.name;
    //   Reference storageRef =
    //       FirebaseStorage.instance.ref().child('${heading}/$fileName');
    //   UploadTask uploadTask = storageRef.putFile(File(image.path));

    //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    //   String downloadURL = await taskSnapshot.ref.getDownloadURL();
    //   url.add(downloadURL);
    // }
    // Update Firestore document
    await FirebaseFirestore.instance
        .collection(heading)
        .doc(documentId)
        .update({
      'image_url': image,
      'title': title,
      'description': description,
    });
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteBlog(String heading, String documentId) async {
    _isLoading = true;
    notifyListeners();

    // List<String> url = [];
    // for (var image in _images) {
    //   String fileName = image.name;
    //   Reference storageRef =
    //       FirebaseStorage.instance.ref().child('${heading}/$fileName');
    //   UploadTask uploadTask = storageRef.putFile(File(image.path));

    //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    //   String downloadURL = await taskSnapshot.ref.getDownloadURL();
    //   url.add(downloadURL);
    // } 
    // Update Firestore document
    await FirebaseFirestore.instance
        .collection(heading)
        .doc(documentId)
        .delete();
    _isLoading = false;
    notifyListeners();
  }
}
