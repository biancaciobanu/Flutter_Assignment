import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/blocs/contact_bloc.dart';
import 'application/screens/contact_list_screen.dart';
import 'data/contact_data.dart';
import 'data/contact_repository_impl.dart';
import 'domain/repositories/contact_repository.dart';
void main() {
  final ContactRepository contactRepository = ContactRepositoryImpl(ContactData());
  final ContactBloc contactBloc = ContactBloc(contactRepository);

  runApp(MyApp(
    contactRepository: contactRepository,
    contactBloc: contactBloc,
  ));
}

class MyApp extends StatelessWidget {
  final ContactRepository contactRepository;
  final ContactBloc contactBloc;

  const MyApp({
    Key? key,
    required this.contactRepository,
    required this.contactBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<ContactBloc>(
        create: (context) => contactBloc,
        child: const ContactListScreen(),
      ),
    );
  }
}