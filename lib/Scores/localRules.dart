import 'package:flutter/material.dart';

class localRules extends StatelessWidget {
  const localRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
          child: Image.asset('assets/localRules.png'),
      ),
    );
  }
}