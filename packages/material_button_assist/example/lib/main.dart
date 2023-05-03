import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Hello World!'),
              ),
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('Hello World!'),
              ),
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('Hello World!'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Hello World!'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Hello World!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
