import 'package:flutter_assignment_2/data/contact_data.dart';
import 'package:flutter_assignment_2/domain/entities/contact.dart';
import 'package:flutter_assignment_2/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl(ContactData contactData);

  @override
  Future<List<Contact>> getContacts() {
    // Implement fetching contacts
    throw UnimplementedError();
  }

  @override
  Future<void> addContact(Contact contact) {
    // Implement adding a contact
    throw UnimplementedError();
  }

  @override
  Future<void> updateContact(Contact contact) {
    // Implement updating a contact
    throw UnimplementedError();
  }

  @override
  Future<void> deleteContact(String contactId) {
    // Implement deleting a contact
    throw UnimplementedError();
  }

  @override
  Future<Contact> getContactById(String id) {
    // Implement fetching a contact by ID
    throw UnimplementedError();
  }
}
