import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin_app/providers/category.dart';
import 'package:restaurant_admin_app/providers/product.dart';
import 'package:restaurant_admin_app/providers/user.dart';
import 'package:restaurant_admin_app/screens/dashboard_screen.dart';
import 'package:restaurant_admin_app/services/change_screen_helper.dart';
import 'package:restaurant_admin_app/widgets/custom_text.dart';

import 'login.dart';


class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);


    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150.00,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: authProvider.name,
                decoration: InputDecoration(
                  hintText: "name",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Text(
                    "Email/Username",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: authProvider.email,
                decoration: InputDecoration(
                  hintText: "email Id",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Text(
                    "Phone No.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: authProvider.phone,
                decoration: InputDecoration(
                  hintText: "phone number",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: authProvider.password,
                decoration: InputDecoration(
                  hintText: "password",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
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
                    if (!await authProvider.signUp()) {
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("SignUp FAILED!")));
                      return;
                    }
                    categoryProvider.loadCategories();
                    productProvider.loadProducts();
                    authProvider.clearController();
                    changeScreenReplacement(context, DashboardScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 10, right: 30, bottom: 10),
                    child: CustomText(
                      text: "Register",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                changeScreen(context, LoginScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Already Registered ? Sign in here",
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}