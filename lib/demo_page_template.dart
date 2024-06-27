import 'package:flutter/material.dart';

class DemoPageTemplate extends StatelessWidget {
  DemoPageTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Clique aqui'),
        ),
      ),
    );
  }
}
