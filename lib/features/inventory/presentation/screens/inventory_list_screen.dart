import 'package:flutter/material.dart';
import 'package:lowline/features/inventory/presentation/screens/add_item_screen.dart';
import 'package:lowline/features/inventory/domain/models/item.dart';
import 'package:lowline/services/firebase/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lowline/features/spaces/domain/models/space.dart';

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<Item>> _inventoryFuture;

  @override
  void initState() {
    super.initState();
    _inventoryFuture = loadInventory();
  }

Future<List<Item>> loadInventory() {
  return _firestoreService
      .getPersonalSpace(FirebaseAuth.instance.currentUser!.uid)
      .then((space) {
    if (space == null) {
      throw Exception('Personal space not found');
    }
    return _firestoreService.getItemsBySpaceId(space.id);
  });
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<List<Item>>(
                future: _inventoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final items = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.quantity.toString()),
                        trailing: const Icon(Icons.edit),
                        
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton.small(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) => const AddItemScreen(),
          isScrollControlled: true,
        );
        setState(() {
          _inventoryFuture = loadInventory();
        });
      },
      child: const Icon(Icons.add),
    ),
  );
}
}
