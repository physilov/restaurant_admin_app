import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin_app/providers/category.dart';
import 'package:restaurant_admin_app/providers/product.dart';
import 'package:restaurant_admin_app/providers/user.dart';
import 'package:restaurant_admin_app/providers/app.dart';

import 'package:restaurant_admin_app/screens/dashboard_screen.dart';
import 'package:restaurant_admin_app/screens/register.dart';
import 'package:restaurant_admin_app/services/change_screen_helper.dart';
import 'package:restaurant_admin_app/widgets/custom_text.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);




    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/dyak.png", width: 180, height: 180,),
              ],
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: authProvider.email,
                  decoration: InputDecoration(
                    hintText: "Emails",
                    hintStyle: TextStyle(color: Colors.red),
                    border: InputBorder.none,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.mail_outline),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: authProvider.password,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red,
                ),
                child: GestureDetector(
                  onTap: () async {
                    if (!await authProvider.signIn()) {
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("LOGIN FAILED!"))
                      );
                      return;
                    }
                   // Loading();
                    categoryProvider.loadCategories();
                    productProvider.loadProducts();
                    authProvider.clearController();
                    changeScreenReplacement(context, DashboardScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 10, right: 30, bottom: 10),
                    child: CustomText(text: "Login", color: Colors.white,),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                changeScreen(context, Registration());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: "Not Registered Yet? Register here",
                  color: Colors.red,),
              ),
            ),
          ],
        ),


      ),

    );
  }
}