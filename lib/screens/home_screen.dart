import 'package:flutter/material.dart';
import "../widgets/widgets.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    return const Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.grey,
        child: Icon(Icons.cast),
      ),
      appBar: PreferredSize(
        preferredSize: Size(200.0, 60.0),
        child: CustomAppBar(),
      ),
    );
  }
}
