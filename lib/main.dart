import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:restaurant_admin_app/providers/app.dart';
import 'package:restaurant_admin_app/providers/category.dart';
import 'package:restaurant_admin_app/providers/product.dart';
import 'package:restaurant_admin_app/providers/user.dart';
import 'package:restaurant_admin_app/screens/dashboard_screen.dart';
import 'package:restaurant_admin_app/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: AuthProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return LoginScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return DashboardScreen();
      default:
        return LoginScreen();
    }
  }
}