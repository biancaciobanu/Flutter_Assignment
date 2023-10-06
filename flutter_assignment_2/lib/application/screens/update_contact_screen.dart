import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/application/blocs/contact_bloc.dart';
import 'package:flutter_assignment_2/application/blocs/contact_event.dart';
import 'package:flutter_assignment_2/domain/entities/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;

  const UpdateContactScreen({Key? key, required this.contact})
      : super(key: key);

  @override
  State<UpdateContactScreen> createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController landlineController;

  bool isFavorite = false;
  String? photoPath;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.contact.name);
    mobileController =
        TextEditingController(text: widget.contact.mobilePhoneNumber);
    landlineController =
        TextEditingController(text: widget.contact.landlineNumber);

    // Initialize isFavorite with the contact's status
    isFavorite = widget.contact.isFavorite;
    photoPath = widget.contact.photoPath;
  }

  Future<void> _takeOrBrowsePhoto() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        photoPath = pickedImage.path;
      });
    }
  }

  void _updateContact() {
    final updatedContact = Contact(
      id: widget.contact.id,
      name: nameController.text,
      mobilePhoneNumber: mobileController.text,
      landlineNumber: landlineController.text,
      // Update isFavorite with the current value
      isFavorite: isFavorite,
      photoPath: photoPath ?? '',
    );

    final contactBloc = BlocProvider.of<ContactBloc>(context);
    contactBloc.add(UpdateContactEvent(updatedContact));

    Navigator.pop(context); // Close the screen after updating contact
  }

  void _deleteContact() {
    final contactBloc = BlocProvider.of<ContactBloc>(context);
    contactBloc.add(DeleteContactEvent(widget.contact.id.toString()));

    Navigator.pop(context); // Close the screen after deleting contact
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Contact',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                // Toggle isFavorite status
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              Icons.star,
              color: isFavorite ? Colors.yellow : Colors.grey,
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: _takeOrBrowsePhoto,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: photoPath != null
                      ? ClipOval(
                          child: Image.file(
                            File(photoPath!),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          Icons.camera_alt,
                          size: 60,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Name'),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: nameController,
                      onChanged: (value) {
                        setState(() {
                          // Name changed
                        });
                      },
                      decoration: const InputDecoration(
                        // labelText: 'Name', // Add a label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Mobile'),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: mobileController,
                      onChanged: (value) {
                        setState(() {
                          // Mobile phone number changed
                        });
                      },
                      decoration: const InputDecoration(
                        // labelText: 'Mobile Phone', // Add a label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Landline'),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: landlineController,
                      onChanged: (value) {
                        setState(() {
                          // Landline number changed
                        });
                      },
                      decoration: const InputDecoration(
                        // labelText: 'Landline', // Add a label
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0), // Adjust the top padding as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _updateContact,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _deleteContact,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 304),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when the screen is disposed
    nameController.dispose();
    mobileController.dispose();
    landlineController.dispose();
    super.dispose();
  }
}
