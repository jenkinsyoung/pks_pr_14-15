import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr_12/src/ui/pages/basket_page.dart';
import 'package:pr_12/src/ui/pages/favorite_page.dart';
import 'package:pr_12/src/ui/pages/home_page.dart';
import 'package:pr_12/src/ui/pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(76, 23, 0, 1.0)),
          useMaterial3: true,
          textTheme: GoogleFonts.nunitoSansTextTheme(
              Theme.of(context).textTheme
          )
      ),
      home: const MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = _auth.currentUser != null;
    final List<Widget>  widgetOptions = <Widget>[
    const HomePage(),
      if (isAuthenticated) const FavoritePage(),
      if (isAuthenticated) const BasketPage(),
      const ProfilePage(),
    ];
    return Scaffold(
      body:
      widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[

          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded,
              color: Color.fromRGBO(76, 23, 0, 1.0),),
            label: 'Главная',
          ),
          if (isAuthenticated) const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded,
              color: Color.fromRGBO(76, 23, 0, 1.0),),
            label: 'Избранное',
          ),
          if (isAuthenticated) const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
              color: Color.fromRGBO(76, 23, 0, 1.0),),
            label: 'Корзина',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person,
              color: Color.fromRGBO(76, 23, 0, 1.0),),
            label: 'Профиль',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(76, 23, 0, 1.0),
        onTap: _onItemTapped,
      ),
    );
  }
}
