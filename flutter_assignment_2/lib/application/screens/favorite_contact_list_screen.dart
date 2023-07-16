import 'package:flutter/material.dart';
class FavoriteContactListScreen extends StatefulWidget {
  const FavoriteContactListScreen({super.key});

  @override
  State<FavoriteContactListScreen> createState() => _FavoriteContactListScreenState();
}

class _FavoriteContactListScreenState extends State<FavoriteContactListScreen> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Contact List'),
      ),
      body: Container(),
    );
  }
}