import 'package:cloud_firestore/cloud_firestore.dart';

class AppInitialization {
  static void initializeApp() {
    Firestore.instance.settings(persistenceEnabled: true);
  }
}
