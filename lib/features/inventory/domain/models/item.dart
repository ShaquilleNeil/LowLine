// Item: a tracked item with a barcode, quantity, and low-stock threshold.
//
// Fields (to be implemented):
//   - id
//   - spaceId
//   - name
//   - barcodeValue
//   - barcodeType
//   - quantity
//   - lowStockThreshold
//   - isBelowThreshold
//   - category
//   - imageUrl
//   - timestamps

import 'package:cloud_firestore/cloud_firestore.dart';

 enum BarcodeType { internal, external, none}
class Item {
  final String id;
  final String spaceId;
  final String name;
  final String barcodeValue;
  final BarcodeType barcodeType;
  final int quantity;
  final int lowStockThreshold;
  final bool isBelowThreshold;
  final String? category;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Item({
    required this.id,
    required this.spaceId,
    required this.name,
    required this.barcodeValue,
    required this.barcodeType,
    required this.quantity,
    required this.lowStockThreshold,
    this.isBelowThreshold = false,
    this.category,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromFirestore(DocumentSnapshot doc) {
     final data = doc.data() as Map<String, dynamic>;

     return Item(
      id: doc.id,
      spaceId: data['spaceId'] as String,
      name: data['name'] as String,
      barcodeValue: data['barcodeValue'] as String,
      barcodeType: BarcodeType.values.byName(data['barcodeType'] as String),
      quantity: data['quantity'] as int,
      lowStockThreshold: data['lowStockThreshold'] as int,
      isBelowThreshold: data['isBelowThreshold'] as bool? ?? false,
      category: data['category'] as String?,
      imageUrl: data['imageUrl'] as String?,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
     );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'spaceId': spaceId,
      'name': name,
      'barcodeValue': barcodeValue,
      'barcodeType': barcodeType.name,
      'quantity': quantity,
      'lowStockThreshold': lowStockThreshold,
      'isBelowThreshold': isBelowThreshold,
      'category': category,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Item copyWith({
    String? name,
    int? quantity,
    int? lowStockThreshold,
    bool? isBelowThreshold,
    String? category,
    String? imageUrl,
    DateTime? updatedAt,
  }) {
    return Item(
      id: id,
      spaceId: spaceId,
      barcodeValue: barcodeValue,
      barcodeType: barcodeType,
      createdAt: createdAt,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      isBelowThreshold: isBelowThreshold ?? this.isBelowThreshold,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
