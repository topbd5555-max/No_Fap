import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D17), 
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Hi 👋', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white70),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF8A2BE2).withOpacity(0.4), width: 6),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8A2BE2).withOpacity(0.15),
                    blurRadius: 30,
                    spreadRadius: 10,
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('0', style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('Days', style: TextStyle(fontSize: 20, color: Colors.white70)),
                  SizedBox(height: 12),
                  Text('00 : 00 : 41', style: TextStyle(fontSize: 16, color: Color(0xFFB388FF), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text('Goal 4 day', style: TextStyle(fontSize: 18, color: Colors.white54)),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8A2BE2).withOpacity(0.2),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: const Color(0xFF8A2BE2).withOpacity(0.5)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14)
            ),
            onPressed: () {},
            child: const Text('Reset', style: TextStyle(color: Color(0xFFE0B0FF), fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0xFF161625),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Your progress over time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Sep 22 - today', style: TextStyle(color: Colors.white54, fontSize: 14)),
                  SizedBox(height: 5),
                  Text('0 days', style: TextStyle(fontSize: 24, color: Color(0xFFB388FF), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D0D17),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFB388FF),
        unselectedItemColor: Colors.white30,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.flag_rounded), label: 'Roadmap'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_rounded), label: 'Resources'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline_rounded), label: 'Info'),
        ],
      ),
    );
  }
}
