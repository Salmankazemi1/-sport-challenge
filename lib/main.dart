import 'package:flutter/material.dart';

void main() {
  runApp(const SportChallengeApp());
}

class SportChallengeApp extends StatelessWidget {
  const SportChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sport Challenge 5',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  int points = 0;

  final List<String> challenges = [
    '10 دقیقه دویدن',
    '30 حرکت اسکوات',
    '20 حرکت شنا',
    '15 دقیقه پیاده‌روی',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sport Challenge 5',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '🏆 $points',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          _home(),
          _challenges(),
          _profile(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'خانه',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'چالش‌ها',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'پروفایل',
          ),
        ],
      ),
    );
  }

  Widget _home() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'سلام ورزشکار! 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'امروز یک چالش را کامل کن و امتیاز بگیر.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.emoji_events, size: 34),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'امتیاز شما',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '$points',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'چالش‌های امروز',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...challenges.take(3).map(_challengeCard),
        ],
      ),
    );
  }

  Widget _challenges() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'همه چالش‌ها 💪',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...challenges.map(_challengeCard),
      ],
    );
  }

  Widget _challengeCard(String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.fitness_center),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('کامل کن و 10 امتیاز بگیر'),
        trailing: FilledButton(
          onPressed: () {
            setState(() {
              points += 10;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('چالش انجام شد! +10 امتیاز 🏆'),
              ),
            );
          },
          child: const Text('انجام'),
        ),
      ),
    );
  }

  Widget _profile() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 55,
              child: Icon(Icons.person, size: 60),
            ),
            const SizedBox(height: 20),
            const Text(
              'ورزشکار Sport Challenge',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'امتیاز فعلی: $points',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
