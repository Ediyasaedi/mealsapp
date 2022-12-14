import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  static const routeName = '/tabs-screen';

  TabScreen(this.favoriteMeals);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

// class _TabScreenState extends State<TabScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Meal'),
//           bottom: TabBar(tabs: [
//             Tab(
//               icon: Icon(Icons.category),
//               text: 'Categories',
//             ),
//             Tab(
//               icon: Icon(Icons.star),
//               text: 'Favorites',
//             ),
//           ]),
//         ),
//         body: TabBarView(
//           children: [CategoriesScreen(), FavoritesScreen()],
//         ),
//       ),
//     );
//   }
// }

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorites'},
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title'] as String),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).cardColor,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).cardColor,
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).cardColor,
              icon: Icon(Icons.star),
              label: 'Favorites',
            )
          ],
        ),
      ),
    );
  }
}
