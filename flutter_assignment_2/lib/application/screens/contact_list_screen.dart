import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/application/blocs/contact_bloc.dart';
import 'package:flutter_assignment_2/application/blocs/contact_event.dart';
import 'package:flutter_assignment_2/application/screens/create_contact_screen.dart';
import 'package:flutter_assignment_2/application/screens/favorite_contact_list_screen.dart';
import 'package:flutter_assignment_2/application/screens/update_contact_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/contact_state.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactBloc contactBloc = BlocProvider.of<ContactBloc>(context);
    contactBloc.add(LoadContactsEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Contact List',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Contact List'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Favorite Contacts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteContactListScreen(
                      favoriteContacts: [],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Add New Contact'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateContactScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactLoadedState) {
            final contacts = state.contacts;
            contacts.sort(
                (a, b) => a.name.compareTo(b.name)); // Sort contacts by name

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: _buildContactPhoto(contact.photoPath), // Add leading to display photo
                  title: Text(contact.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateContactScreen(contact: contact),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ContactErrorState) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return const Center(
            child: Text('No contacts found.'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateContactScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildContactPhoto(String? photoPath) {
    if (photoPath != null && photoPath.isNotEmpty) {
      return ClipOval(
        child: Image.file(
          File(photoPath),
          width: 48, // Customize the width as needed
          height: 48, // Customize the height as needed
          fit: BoxFit.cover,
        ),
      );
    } else {
      return const Icon(
        Icons.person, // You can use a default icon when no photo is available
        size: 48, // Customize the size as needed
      );
    }
  }
}
