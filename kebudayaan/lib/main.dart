import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kebudayaan/screen_pages/SplashScreen.dart';
import 'package:kebudayaan/screen_pages/page_gallery_photo.dart';
import 'package:kebudayaan/screen_pages/page_list_berita.dart';
import 'package:kebudayaan/screen_pages/page_list_sejarawan.dart';
import 'package:kebudayaan/screen_pages/page_user.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            PageListBerita(),
            PageGalleryFoto(),
            PageListSejarahwan(),
            PageUser()
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          waterDropColor: Colors.white,
          backgroundColor: Colors.blue,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.newspaper_rounded,
              outlinedIcon: Icons.newspaper_outlined,
            ),
            BarItem(
              filledIcon: Icons.crop_original_rounded,
              outlinedIcon: Icons.crop_original_outlined,
            ),
            BarItem(
              filledIcon: Icons.drive_file_rename_outline_rounded,
              outlinedIcon: Icons.drive_file_rename_outline_outlined,
            ),
            BarItem(
              filledIcon: Icons.perm_identity_rounded,
              outlinedIcon: Icons.perm_identity_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
