// Space: an inventory container, personal or shared.
//
// Fields (to be implemented):
//   - id
//   - name
//   - ownerId
//   - memberIds
//   - pendingInvites
//   - createdAt
import 'package:cloud_firestore/cloud_firestore.dart';
class Space {
  final String id;
  final String name;
  final String ownerId;
  final List<String> memberIds;

  final DateTime createdAt;



  Space({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.memberIds,
    required this.createdAt,
  });


  factory Space.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Space(
      id: doc.id,
      name: data['name'] as String,
      ownerId: data['ownerId'] as String,
      memberIds: List<String>.from(data['memberIds'] as List<dynamic>),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }


  Map<String, dynamic> toFirestore(){
    return {
      'name': name,
      'ownerId': ownerId,
      'memberIds': memberIds,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Space copyWith({
    String? name,
    List<String>? memberIds,
  }) {
    return Space(
      id: id,
      name: name ?? this.name,
      ownerId: ownerId,
      memberIds: memberIds ?? this.memberIds,
      createdAt: createdAt,
    );
  }
}
