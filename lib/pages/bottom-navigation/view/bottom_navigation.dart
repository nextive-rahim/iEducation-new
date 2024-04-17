import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ieducation/pages/blogs/controller/blog_controller.dart';
import 'package:ieducation/pages/blogs/view/blog.dart';
import 'package:ieducation/pages/bottom-navigation/controller/bottom_navigation_controller.dart';
import 'package:ieducation/pages/course/controller/course_controller.dart';
import 'package:ieducation/pages/course/view/all_course.dart';
import 'package:ieducation/pages/drawer/drawer.dart';
import 'package:ieducation/pages/home/controller/home_controller.dart';
import 'package:ieducation/pages/home/view/home_page.dart';
import 'package:ieducation/pages/products/controller/product_controller.dart';
import 'package:ieducation/pages/products/view/product_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final bottomNavigationController = Get.put(BottomNavigationController());
  final courseController = Get.put(CourseController(), permanent: true);
  final homeController = Get.put(HomeController(), permanent: true);
  @override
  void initState() {
    Get.put(ProductController(), permanent: true);
    Get.put(BlogController(), permanent: true);
    homeController.getUserInfo();
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    const HomePage(),
    const AllCoursePage(),
    ProductPage(),
    const BlogPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        } else {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? const Icon(
                      Icons.home,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.home,
                      color: Colors.black26,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? const Icon(
                      Icons.menu_book,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.menu_book,
                      color: Colors.black26,
                    ),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? const Icon(
                      Icons.cases_outlined,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.cases_outlined,
                      color: Colors.black26,
                    ),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 3
                  ? const Icon(
                      Icons.newspaper,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.newspaper,
                      color: Colors.black26,
                    ),
              label: 'Blogs',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.red,
          onTap: _onItemTapped,
        ),
        drawer: const GetDrawer(),
      ),
    );
  }
}
