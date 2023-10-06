import 'package:flutter_assignment_2/data/contact_data.dart';
import 'package:flutter_assignment_2/domain/entities/contact.dart';
import 'package:flutter_assignment_2/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactData contactData;

  ContactRepositoryImpl(this.contactData);

  @override
  Future<List<Contact>> getContacts() async {
    return contactData.getContacts();
  }

  @override
  Future<void> addContact(Contact contact) async {
    await contactData.addContact(contact);
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await contactData.updateContact(contact);
  }

  @override
  Future<void> deleteContact(String contactId) async {
    await contactData.deleteContact(int.parse(contactId));
  }

  @override
  Future<Contact> getContactById(String id) async {
    return contactData.getContactById(int.parse(id));
  }
}
