import 'package:flutter_assignment_2/domain/entities/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadContactsEvent extends ContactEvent {}

class AddContactEvent extends ContactEvent {
  final Contact contact;

  AddContactEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class UpdateContactEvent extends ContactEvent {
  final Contact contact;

  UpdateContactEvent(this.contact);

  @override
  List<Object?> get props => [contact];
}

class DeleteContactEvent extends ContactEvent {
  final String contactId;

  DeleteContactEvent(this.contactId);

  @override
  List<Object?> get props => [contactId];
}

class ToggleFavoriteEvent extends ContactEvent {
  final String contactId;

  ToggleFavoriteEvent(this.contactId);

  @override
  List<Object?> get props => [contactId];
}
