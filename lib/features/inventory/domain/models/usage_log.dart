// UsageLog: a record of quantity changes for an item.
//
// Fields (to be implemented):
//   - id
//   - itemId
//   - spaceId
//   - userId
//   - delta
//   - source
//   - timestamp
import 'package:cloud_firestore/cloud_firestore.dart';

enum Source {scan, manual}
class UsageLog {
  final String id;
  final String itemId;
  final String spaceId;
  final String userId;
  final int delta;
  final Source source;
  final DateTime timestamp;

  UsageLog({
    required this.id,
    required this.itemId,
    required this.spaceId,
    required this.userId,
    required this.delta,
    required this.source,
    required this.timestamp,
  });


  factory UsageLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UsageLog(
      id: doc.id,
      itemId: data['itemId'] as String,
      spaceId: data['spaceId'] as String,
      userId: data['userId'] as String,
      delta: data['delta'] as int,
      source: Source.values.byName(data['source'] as String),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'itemId': itemId,
      'spaceId': spaceId,
      'userId': userId,
      'delta': delta,
      'source': source.name,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
