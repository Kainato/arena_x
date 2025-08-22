import 'package:arena_x/utils/widgets/layout/wd_appbar.dart';
import 'package:flutter/material.dart';

class WdScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const WdScaffold({super.key, required this.title, required this.body});

  static Scaffold bottomNavigation({
    required String title,
    required List<Widget> body,
    required int currentIndex,
    required List<BottomNavigationBarItem> bottomNavigationBar,
    required ValueChanged<int> onTap,
  }) {
    return Scaffold(
      appBar: WdAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
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
      appBar: WdAppbar(),
      body: Padding(padding: const EdgeInsets.all(12.0), child: body),
    );
  }
}
