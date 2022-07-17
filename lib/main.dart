import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_analysis/screens/actors_table_page.dart';
import 'package:netflix_analysis/screens/analysis_page.dart';
import 'package:netflix_analysis/screens/directors_table_page.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    ActorsTablePage(),
    DirectorsTablePage(),
    AnalysisPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.recent_actors), label: 'Actors'),
          NavigationDestination(icon: Icon(Icons.account_box), label: 'Directors'),
          NavigationDestination(icon: Icon(Icons.auto_graph), label: 'Analysis'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
