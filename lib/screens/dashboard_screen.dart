import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin_app/providers/product.dart';
import 'package:restaurant_admin_app/providers/user.dart';
import 'package:restaurant_admin_app/screens/order_screen.dart';
import 'package:restaurant_admin_app/screens/product_screen.dart';
import 'package:restaurant_admin_app/services/change_screen_helper.dart';
import 'package:restaurant_admin_app/widgets/custom_text.dart';
import 'package:restaurant_admin_app/widgets/product_widget.dart';
import 'package:restaurant_admin_app/widgets/small_button.dart';
import 'package:transparent_image/transparent_image.dart';

import 'add_products.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    bool hasImage = false;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.purple,
        title: CustomText(
          text: "Sales: \$${authProvider.totalSales}",
          color: Colors.white,
        ),
        actions: <Widget>[],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              accountName: CustomText(
                text: authProvider.restaurant?.name ?? "",
                color: Colors.white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: authProvider.user.email ?? "",
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "Orders"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, ProductsScreen());
              },
              leading: Icon(Icons.fastfood),
              title: CustomText(text: "Products"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
//                  Positioned.fill(
//                      child: Align(
//                        alignment: Alignment.center,
//                        child: Loading(),
//                      )),

                  // restaurant image
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                      child: imageWidget(hasImage: hasImage)),

                  // fading black
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        )),
                  ),

                  //restaurant name
                  Positioned.fill(
                      bottom: 30,
                      left: 10,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: CustomText(
                            text: 'Santos Corner',
                            color: Colors.white,
                            size: 24,
                            weight: FontWeight.normal,
                          ))),

                  // average price
                  Positioned.fill(
                      bottom: 10,
                      left: 10,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: CustomText(
                            text: "Average Price: \$5.5",
                            color: Colors.white,
                            size: 16,
                            weight: FontWeight.w300,
                          ))),

                  // close button
                  Positioned.fill(
                      top: 5,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black.withOpacity(0.3)),
                                child: TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    label: CustomText(
                                      text: "Edit",
                                      color: Colors.white,
                                    ))),
                          ),
                        ),
                      )),

                  Positioned.fill(
                      bottom: 2,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow[900],
                                    size: 20,
                                  ),
                                ),
                                Text("4.5"),
                              ],
                            ),
                          ),
                        ),
                      )),

                  //like button
                  Positioned.fill(
                      top: 5,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: () {},
                            child: SmallButton(Icons.favorite),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("images/delivery.png"),
                        ),
                        title: CustomText(
                          text: "Orders",
                          size: 24,
                        ),
                        trailing: CustomText(
                          text: "30",
                          size: 24,
                          weight: FontWeight.bold,
                        )),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("images/fd.png"),
                        ),
                        title: CustomText(
                          text: "Total Food",
                          size: 24,
                        ),
                        trailing: CustomText(
                          text: "30",
                          size: 24,
                          weight: FontWeight.bold,
                        )),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: ListTile(
                        onTap: (){
                          changeScreen(context, ProductsScreen());
                        },
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("images/fd.png"),
                        ),
                        title: CustomText(
                          text: "Products",
                          size: 24,
                        ),
                        trailing: CustomText(
                          text: authProvider.products.length.toString(),
                          size: 24,
                          weight: FontWeight.bold,
                        )),
                  ),
                ),
              ),

              Column(
                children: authProvider.products
                    .map((item) => GestureDetector(
                  onTap: () {
                     //changeScreen(context, Details(product: item,));
                  },
                  child: ProductWidget(
                    product: item,
                  ),
                ))
                    .toList(),
              )


              // products
//              Column(
//                children: productProvider.productsByRestaurant
//                    .map((item) => GestureDetector(
//                  onTap: () {
//                    changeScreen(context, Details(product: item,));
//                  },
//                  child: ProductWidget(
//                    product: item,
//                  ),
//                ))
//                    .toList(),
//              )
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        changeScreen(context, AddProductScreen());
      },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        tooltip: 'Add Product',),
    );
  }

  Widget imageWidget({bool hasImage, String url}) {
    if (hasImage)
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        height: 160,
        fit: BoxFit.fill,
        width: double.infinity,
      );

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                size: 40,
              ),
            ],
          ),
          CustomText(text: "No Photo")
        ],
      ),
      height: 160,
    );
  }
}