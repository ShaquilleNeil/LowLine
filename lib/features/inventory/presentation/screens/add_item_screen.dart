import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lowline/features/inventory/domain/models/item.dart';
import 'package:lowline/services/firebase/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController();
  final TextEditingController _itemThresholdController = TextEditingController();
  String? _selectedCategory;
  final FirestoreService _firestoreService = FirestoreService();
    final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  final TextEditingController _imageUrlController = TextEditingController();

 
@override
void dispose() {
    _itemNameController.dispose();
    _itemQuantityController.dispose();
    _itemThresholdController.dispose();
    super.dispose();
  }


Future<void> _pickImage() async {
  final XFile? picked = await _imagePicker.pickImage(source: ImageSource.gallery);
  if (picked != null) {
    setState(() {
      _selectedImage = picked;
    });
  }
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
                Form(
                  key: _formGlobalKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Stack(
                                children: [
                                  _selectedImage == null
                                      ? const Center(child: Text('No image selected'))
                                      : Image.file(
                                          File(_selectedImage!.path),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      onPressed: _pickImage,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),

                      SizedBox(height: 20),
                      TextFormField(
                        controller: _itemNameController,
                        decoration: InputDecoration(
                          labelText: 'Item Name',
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: ['Electronics', 'Clothing', 'Food', 'Books', 'Other']
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Item Category',
                        ),
                      ),
                      TextFormField(
                        controller: _itemQuantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Item Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter item quantity';
                          }
                          final parsedValue = int.tryParse(value);
                          if (parsedValue == null) {
                            return 'Please enter a valid number';
                          }
                          if (parsedValue < 1) {
                            return 'Quantity must be at least 1';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _itemThresholdController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Item Threshold',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter item threshold';
                          }
                          final parsedValue = int.tryParse(value);
                          if (parsedValue == null) {
                            return 'Please enter a valid number';
                          }
                          if (parsedValue < 1) {
                            return 'Threshold must be at least 1';
                          }
                          return null;
                        },
                      ),

                        SizedBox(height: 30), 

                      ElevatedButton(
                        child: const Text('Add Item'),
                        onPressed: () async {
                          if (_formGlobalKey.currentState!.validate()) {
                            final space = await _firestoreService.getPersonalSpace(FirebaseAuth.instance.currentUser!.uid);
                            if (space == null) {
                              // Handle the case where the personal space is not found
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Personal space not found. Please create a space first.')),
                              );
                              return;
                            }
                             // Replace 'userId' with the actual user ID
                            final Item item = Item(
                              id: '', // Firestore will generate the ID
                              spaceId: space.id,
                              name: _itemNameController.text,
                              category: _selectedCategory,
                              quantity: int.parse(_itemQuantityController.text),
                              lowStockThreshold: int.parse(_itemThresholdController.text),
                              isBelowThreshold: false,
                              barcodeValue: '',
                              barcodeType: BarcodeType.none,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            await _firestoreService.createItem(item);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Item Added'),
                                content: const Text('The item has been added to your inventory.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(); // Close the AddItemScreen
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),    
                            );
                            // Add item to inventory
                          }
                        },
                      ),
                    ],

                  ),  
                ),
              ],
            ),
          ),
        )),
    );
  }
}
