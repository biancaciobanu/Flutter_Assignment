import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/application/blocs/contact_bloc.dart';
import 'package:flutter_assignment_2/application/blocs/contact_event.dart';
import 'package:flutter_assignment_2/application/screens/contact_list_screen.dart';
import 'package:flutter_assignment_2/domain/entities/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({Key? key}) : super(key: key);

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  String? name;
  String? mobilePhoneNumber;
  String? landlineNumber;
  bool isFavorite = false;
  String? photoPath;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _takeOrBrowsePhoto() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        photoPath = pickedImage.path;
      });
    }
  }

  void _saveContact(BuildContext context) {
    if (name != null && name!.isNotEmpty) {
      final newContact = Contact(
        name: name!,
        mobilePhoneNumber: mobilePhoneNumber ?? '',
        landlineNumber: landlineNumber ?? '',
        isFavorite: isFavorite,
        photoPath: photoPath ?? '',
      );

      final ContactBloc contactBloc = BlocProvider.of<ContactBloc>(context);

      contactBloc.add(AddContactEvent(newContact));

      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ContactListScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Contact',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
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
            const SizedBox(height: 50),
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
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        setState(() {
                          mobilePhoneNumber = value;
                        });
                      },
                      decoration: const InputDecoration(
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
                      onChanged: (value) {
                        setState(() {
                          landlineNumber = value;
                        });
                      },
                      decoration: const InputDecoration(
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _saveContact(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.grey,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
