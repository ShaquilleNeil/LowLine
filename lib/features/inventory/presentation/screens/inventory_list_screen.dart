import 'package:flutter/material.dart';
import 'package:lowline/features/inventory/presentation/screens/add_item_screen.dart';

class InventoryListScreen extends StatelessWidget {
  const InventoryListScreen({super.key});

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
                FloatingActionButton.small(onPressed: () {
                  showModalBottomSheet(context: context, builder: (context) => const AddItemScreen(), isScrollControlled: true);
                }, child: const Icon(Icons.add)),
                const Text("Inventory List Screen"),
              ],
            ),
          ),
        )
      ),
    );
  }
}
