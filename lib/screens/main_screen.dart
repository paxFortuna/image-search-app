import 'package:flutter/material.dart';
import 'package:image_search_app/screens/screens/image_screen/image_search_screen.dart';
import 'package:image_search_app/screens/screens/image_stream_screen/image_Stream_screen.dart';
import 'package:image_search_app/screens/screens/video_screen/video_seach_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationWidget(),
    );
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return const ImageSearchApp();
      case 1:
        return const VideoSearchScreen();
      case 2:
        return const ImageStreamScreen();
      case 3:
        return const Center(
          child: Text("Mbti"),
        );
      default:
        return const Center(child: Text("Favorite"));
    }
  }

  Widget _bottomNavigationWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentPageIndex,
      onTap: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 22,
            ),
            activeIcon: Icon(
              Icons.photo_camera_outlined,
              size: 22,
            ),
            label: "Photo"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.video_file,
              size: 22,
            ),
            activeIcon: Icon(
              Icons.video_file_outlined,
              size: 22,
            ),
            label: "Video"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_outlined,
              size: 22,
            ),
            activeIcon: Icon(
              Icons.chat_rounded,
              size: 22,
            ),
            label: "Stream"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.propane,
              size: 22,
            ),
            activeIcon: Icon(
              Icons.propane_outlined,
              size: 22,
            ),
            label: "MBTI"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              size: 22,
            ),
            activeIcon: Icon(
              Icons.library_books_outlined,
              size: 22,
            ),
            label: "Favorite"),
      ],
    );
  }
}