import 'package:flutter/material.dart';
import 'package:restaurant_admin_app/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin_app/widgets/custom_text.dart';
import 'package:restaurant_admin_app/widgets/product_widget.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductsScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: CustomText(text: "Products",),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: userProvider.products.map((item) => GestureDetector(
          onTap: (){},
          child: ProductWidget(
            product: item,
          ),
        )).toList(),

      ),
    );
  }
}
