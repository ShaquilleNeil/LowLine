// Firestore service — empty for now.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lowline/features/inventory/domain/models/item.dart';
import 'package:lowline/features/spaces/domain/models/space.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPersonalSpace(String uid) async {
     Map<String, dynamic> personalSpaceData = {
      'createdAt': FieldValue.serverTimestamp(),
      'name': 'My Space',
      'ownerId': uid,
      'memberIds': [uid],
      // Add other fields as necessary
    };

    await _db.collection('spaces').add(personalSpaceData);
  }

  Future<Space?> getPersonalSpace(String uid) async {
    final snapshot = await _db.collection('spaces').where('ownerId', isEqualTo: uid).limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      return Space.fromFirestore(snapshot.docs.first);
    }
    return null;
  }

Future<void> createItem(Item item) async {
  await _db.collection('items').add(item.toFirestore());
  }

Future<List<Item>> getItemsBySpaceId(String spaceId) async {
  final snapshot = await _db.collection('items').where('spaceId', isEqualTo: spaceId).get();
  return snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
}

Future<void> updateItem(Item item) async {
  final data = item.toFirestore();
  data['updatedAt'] = Timestamp.now();
  await _db.collection('items').doc(item.id).update(data);
}

Future<void> deleteItem(Item item) async {
  await _db.collection('items').doc(item.id).delete();
}

  
  
}