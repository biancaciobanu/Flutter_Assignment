import 'package:bloc/bloc.dart';
import 'package:flutter_assignment_2/application/blocs/contact_event.dart';
import 'package:flutter_assignment_2/application/blocs/contact_state.dart';
import 'package:flutter_assignment_2/domain/repositories/contact_repository.dart';
import 'package:flutter_assignment_2/domain/entities/contact.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;
  List<Contact> favoriteContacts = []; // List of favorite contacts

  ContactBloc(this.contactRepository) : super(ContactLoadingState());

  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is LoadContactsEvent) {
      yield* _mapLoadContactsEventToState();
    } else if (event is AddContactEvent) {
      yield* _mapAddContactEventToState(event);
    } else if (event is UpdateContactEvent) {
      yield* _mapUpdateContactEventToState(event);
    } else if (event is DeleteContactEvent) {
      yield* _mapDeleteContactEventToState(event);
    } else if (event is ToggleFavoriteEvent) {
      yield* _mapToggleFavoriteEventToState(event);
    }
  }

  Stream<ContactState> _mapLoadContactsEventToState() async* {
    yield ContactLoadingState();
    try {
      final contacts = await contactRepository.getContacts();
      favoriteContacts = contacts.where((contact) => contact.isFavorite).toList();
      yield ContactLoadedState(contacts);
    } catch (e) {
      yield ContactErrorState('Failed to load contacts: $e');
    }
  }

  Stream<ContactState> _mapAddContactEventToState(AddContactEvent event) async* {
    try {
      await contactRepository.addContact(event.contact);
      yield* _mapLoadContactsEventToState();
    } catch (e) {
      yield ContactErrorState('Failed to add contact: $e');
    }
  }

  Stream<ContactState> _mapUpdateContactEventToState(UpdateContactEvent event) async* {
    try {
      await contactRepository.updateContact(event.contact);
      yield* _mapLoadContactsEventToState();
    } catch (e) {
      yield ContactErrorState('Failed to update contact: $e');
    }
  }

  Stream<ContactState> _mapDeleteContactEventToState(DeleteContactEvent event) async* {
    try {
      await contactRepository.deleteContact(event.contactId);
      yield* _mapLoadContactsEventToState();
    } catch (e) {
      yield ContactErrorState('Failed to delete contact: $e');
    }
  }

  Stream<ContactState> _mapToggleFavoriteEventToState(ToggleFavoriteEvent event) async* {
    try {
      final contact = await contactRepository.getContactById(event.contactId);
      final updatedContact = contact.copyWith(isFavorite: !contact.isFavorite);
      await contactRepository.updateContact(updatedContact);

      // Update the favoriteContacts list
      if (updatedContact.isFavorite) {
        favoriteContacts.add(updatedContact);
      } else {
        favoriteContacts.removeWhere((contact) => contact.id == updatedContact.id);
      }

      yield* _mapLoadContactsEventToState();
    } catch (e) {
      yield ContactErrorState('Failed to toggle favorite status: $e');
    }
  }
}
