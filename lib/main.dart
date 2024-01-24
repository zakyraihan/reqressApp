import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqress_app/api/api_service.dart';
import 'package:reqress_app/provider/list_provider.dart';
import 'package:reqress_app/ui/list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ListPage(),
      ),
    );
  }
}
