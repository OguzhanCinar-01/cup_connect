import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPanelViewModel extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> getAdminPanelData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching admin panel data: $e');
      return []; // Hata durumunda boş liste döner
    }
  }

  
}
