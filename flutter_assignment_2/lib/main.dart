import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/application/blocs/contact_bloc.dart';
import 'package:flutter_assignment_2/application/screens/contact_list_screen.dart';
import 'package:flutter_assignment_2/data/contact_data.dart';
import 'package:flutter_assignment_2/data/contact_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactBloc>(
          create: (context) =>
              ContactBloc(ContactRepositoryImpl(ContactData())),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: ContactListScreen(),
      ),
    );
  }
}
