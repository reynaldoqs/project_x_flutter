import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlix/core/providers/cRecharge.dart';
import 'package:urlix/locator.dart';
import 'package:urlix/ui/views/recharges.dart';
import 'package:urlix/ui/views/settings.dart';
import 'package:urlix/ui/widgets/bottomNavBar.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<CRechargeProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'urLIX',
        theme: ThemeData(fontFamily: 'OpenSans'),
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreen = 0;

  final List<Widget> _screens = [
    Container(
      child: Center(
          child: Text(
        "Audiman 1",
        style: TextStyle(color: Colors.white),
      )),
    ),
    Recharges(),
    Container(
      child: Center(
          child: Text(
        "Audiman 3",
        style: TextStyle(color: Colors.white),
      )),
    ),
    Settings(),
  ];

  void _navigateTo(int screenIndex) {
    setState(() {
      _currentScreen = screenIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _screens[_currentScreen],
      ),
      bottomNavigationBar: BottomNavBar(
        onTab: _navigateTo,
      ),
    );
  }
}
