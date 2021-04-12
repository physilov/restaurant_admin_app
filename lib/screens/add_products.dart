import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin_app/providers/app.dart';
import 'package:restaurant_admin_app/providers/category.dart';
import 'package:restaurant_admin_app/providers/user.dart';
import 'package:restaurant_admin_app/providers/product.dart';
import 'package:restaurant_admin_app/widgets/custom_file_buttom.dart';


class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final userProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0.0,
        title: Text("Add Product", style: TextStyle(color: Colors.black),),



      ),
      body: ListView(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  child: productProvider?.productImage == null ? CustomFileUploadButton(
                    icon: Icons.image,
                    text: "Add Image",
                    onTap: () async {
                      showModalBottomSheet(context: context, builder: (BuildContext bc){
                        return Container(

                        )
                      })
                    },

                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
