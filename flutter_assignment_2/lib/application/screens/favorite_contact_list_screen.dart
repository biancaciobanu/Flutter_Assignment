import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/domain/entities/contact.dart';

class FavoriteContactListScreen extends StatelessWidget {
  final List<Contact> favoriteContacts;

  const FavoriteContactListScreen({
    Key? key,
    required this.favoriteContacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedFavoriteContacts = List<Contact>.from(favoriteContacts);
    sortedFavoriteContacts.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Contact List'),
      ),
      body: ListView.builder(
        itemCount: sortedFavoriteContacts.length,
        itemBuilder: (context, index) {
          final contact = sortedFavoriteContacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.mobilePhoneNumber),
          );
        },
      ),
    );
  }
}
