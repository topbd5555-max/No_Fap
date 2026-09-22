import 'package:flutter/material.dart';
import 'dart:async'; // Add this for the real-time timer

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
        scaffoldBackgroundColor: const Color(0xFF0D0D17), // Deep aesthetic dark background
      ),
      home: const MainTabNavigator(), // Use a new navigator widget
    );
  }
}

class MainTabNavigator extends StatefulWidget {
  const MainTabNavigator({Key? key}) : super(key: key);

  @override
  _MainTabNavigatorState createState() => _MainTabNavigatorState();
}

class _MainTabNavigatorState extends State<MainTabNavigator> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomeScreen(), // Pass logic to the screen
    const Center(child: Text('Roadmap Page', style: TextStyle(fontSize: 24))), // Placeholder pages
    const Center(child: Text('Resources Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Info Page', style: TextStyle(fontSize: 24))),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0D0D17),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFB388FF),
        unselectedItemColor: Colors.white30,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped, // Call our functional navigation method
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Duration _streakDuration;
  late Timer _timer;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now(); // Record current time as start
    _streakDuration = Duration.zero;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) { // Ensure the widget is still in the tree
        setState(() {
          _streakDuration = DateTime.now().difference(_startTime);
        });
      }
    });
  }

  void _resetStreak() {
    if (mounted) {
      setState(() {
        _startTime = DateTime.now(); // Set new start time
        _streakDuration = Duration.zero;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Critical to cancel the timer on widget dispose
    super.dispose();
  }

  // A helper function to format the duration nicely
  String _formatDuration(Duration duration) {
    String days = duration.inDays.toString().padLeft(1, '0');
    String hours = (duration.inHours % 24).toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    
    // Formatting to D : HH : MM : SS to match image concept
    return "$hours : $minutes : $seconds";
  }

  @override
  Widget build(BuildContext context) {
    String daysText = "${_streakDuration.inDays}";

    return Scaffold( // Embed Scaffold to control body, as requested.
      body: Column(
        children: [
          const SizedBox(height: 50),
          // Aesthetic Circular Progress
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
                children: [
                  Text(daysText, style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Text('Days', style: TextStyle(fontSize: 20, color: Colors.white70)),
                  const SizedBox(height: 12),
                  Text(_formatDuration(_streakDuration), style: const TextStyle(fontSize: 16, color: Color(0xFFB388FF), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text('Goal 4 day', style: TextStyle(fontSize: 18, color: Colors.white54)),
          const SizedBox(height: 20),
          // Neon Reset Button
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
            onPressed: _resetStreak, // Wire up the reset function
            child: const Text('Reset', style: TextStyle(color: Color(0xFFE0B0FF), fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 50),
          // Bottom Progress Section
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
                children: [
                  const Text('Your progress over time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text('Sep 22 - today', style: TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 5),
                  Text('$daysText days', style: const TextStyle(fontSize: 24, color: Color(0xFFB388FF), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
