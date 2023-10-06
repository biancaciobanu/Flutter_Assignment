import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/domain/repositories/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../application/blocs/contact_bloc.dart';
import '../data/contact_data.dart';
import '../data/contact_repository_impl.dart';
import '../application/screens/contact_list_screen.dart';

class ContactListScreenProvider extends StatelessWidget {
  const ContactListScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactRepository contactRepository =
        ContactRepositoryImpl(ContactData());
    final ContactBloc contactBloc = ContactBloc(contactRepository);

    return BlocProvider<ContactBloc>(
      create: (context) => contactBloc,
      child: const ContactListScreen(),
    );
  }
}
