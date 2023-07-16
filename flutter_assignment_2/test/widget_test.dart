// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_assignment_2/application/blocs/contact_bloc.dart';
import 'package:flutter_assignment_2/application/screens/contact_list_screen.dart';
import 'package:flutter_assignment_2/data/contact_data.dart';
import 'package:flutter_assignment_2/data/contact_repository_impl.dart';
import 'package:flutter_assignment_2/domain/repositories/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    final ContactRepository contactRepository = ContactRepositoryImpl(ContactData());
    final ContactBloc contactBloc = ContactBloc(contactRepository);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ContactBloc>.value(
          value: contactBloc,
          child: const ContactListScreen(),
        ),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
