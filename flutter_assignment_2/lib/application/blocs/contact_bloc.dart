import 'package:bloc/bloc.dart';
import 'package:flutter_assignment_2/application/blocs/contact_event.dart';
import 'package:flutter_assignment_2/application/blocs/contact_state.dart';
import 'package:flutter_assignment_2/domain/repositories/contact_repository.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(this.contactRepository) : super(ContactLoadingState());

  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is LoadContactsEvent) {
      yield ContactLoadingState();
      try {
        final contacts = await contactRepository.getContacts();
        yield ContactLoadedState(contacts);
      } catch (e) {
        yield ContactErrorState('Failed to load contacts: $e');
      }
    } else if (event is AddContactEvent) {
    } else if (event is UpdateContactEvent) {
    } else if (event is DeleteContactEvent) {
    } else if (event is ToggleFavoriteEvent) {}
  }
}
