import 'package:flutter/material.dart';
import 'package:news/pages/pages.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => _NavModel()),
      child: const Scaffold(
        body: _paginas(),
        bottomNavigationBar: _Nav(),
      ),
    );
  }
}

class _Nav extends StatelessWidget {
  const _Nav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navModel = Provider.of<_NavModel>(context);
    return BottomNavigationBar(
        selectedItemColor: Colors.red,
        currentIndex: navModel.pageAct,
        onTap: (v) {
          navModel.pageAct = v;
          final newsService = Provider.of<NewsService>(context, listen: false);
          newsService.selectedCat = newsService.selectedCat;
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Categories'),
        ]);
  }
}

class _paginas extends StatelessWidget {
  const _paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavModel = Provider.of<_NavModel>(context);
    return PageView(
      controller: NavModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [TabOn(), TabTw()],
    );
  }
}

class _NavModel extends ChangeNotifier {
  int _pageAct = 0;
  final PageController _pageController = PageController();
  int get pageAct => _pageAct;
  set pageAct(int v) {
    _pageAct = v;
    _pageController.animateToPage(v,
        duration: const Duration(milliseconds: 200), curve: Curves.bounceOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
