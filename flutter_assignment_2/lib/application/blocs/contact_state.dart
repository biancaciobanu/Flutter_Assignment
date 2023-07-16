import 'package:flutter_assignment_2/domain/entities/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactLoadingState extends ContactState {}

class ContactLoadedState extends ContactState {
  final List<Contact> contacts;

  ContactLoadedState(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

class ContactErrorState extends ContactState {
  final String message;

  ContactErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
