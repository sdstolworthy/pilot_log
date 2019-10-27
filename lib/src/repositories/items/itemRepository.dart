import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pilot_log/src/models/Item.dart';

class LogbookEntryRepository {
  static const _userCollectionName = 'users';
  static const _itemCollectionName = 'logbookEntries';

  FirebaseAuth _firebaseAuth;

  LogbookEntryRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  getItems({take = 50, limit = 50, skip = 50}) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    List<DocumentSnapshot> entries = (await Firestore.instance
            .collection(_userCollectionName)
            .document(user.uid)
            .collection(_itemCollectionName)
            .getDocuments())
        .documents
        .toList();
    return entries.isEmpty
        ? <LogbookEntry>[]
        : entries
            .map(
              (DocumentSnapshot entry) => LogbookEntry.fromMap(entry.data),
            )
            .toList();
  }

  saveLogbookEntry(LogbookEntry logbookEntry) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await Firestore.instance
        .collection(_userCollectionName)
        .document(user.uid)
        .collection(_itemCollectionName)
        .document(logbookEntry.id.toString())
        .setData(logbookEntry.toMap());
    return logbookEntry;
  }
}
