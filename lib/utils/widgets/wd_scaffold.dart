import 'package:flutter/material.dart';

class WDScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const WDScaffold({super.key, required this.title, required this.body});

  static Scaffold bottomNavigation({
    required String title,
    required List<Widget> body,
    required int currentIndex,
    required List<BottomNavigationBarItem> bottomNavigationBar,
    required ValueChanged<int> onTap,
  }) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IndexedStack(index: currentIndex, children: body),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: bottomNavigationBar,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(padding: const EdgeInsets.all(16.0), child: body),
    );
  }
}
