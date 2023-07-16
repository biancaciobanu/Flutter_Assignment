import 'package:flutter_assignment_2/domain/entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> getContacts();
  Future<void> addContact(Contact contact);
  Future<void> updateContact(Contact contact);
  Future<void> deleteContact(String contactId);
  Future<Contact> getContactById(String id);
}
