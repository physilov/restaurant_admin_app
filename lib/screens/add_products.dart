import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_admin_app/providers/app.dart';
import 'package:restaurant_admin_app/providers/category.dart';
import 'package:restaurant_admin_app/providers/user.dart';
import 'package:restaurant_admin_app/providers/product.dart';
import 'package:restaurant_admin_app/widgets/custom_file_buttom.dart';
import 'package:restaurant_admin_app/widgets/custom_text.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<ScaffoldState>();
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
        title: Text(
          "Add Product",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: productProvider?.productImage == null
                      ? CustomFileUploadButton(
                          icon: Icons.image,
                          text: "Add Image",
                          onTap: () async {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return Container(
                                    child: new Wrap(
                                      children: [
                                        new ListTile(
                                          leading: new Icon(Icons.image),
                                          title: new Text('From Gallery'),
                                          onTap: () async {
                                            productProvider.getImageFile(
                                                source: ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        new ListTile(
                                          leading: new Icon(Icons.camera_alt),
                                          title: new Text('From Camera'),
                                          onTap: () async {
                                            productProvider.getImageFile(
                                                source: ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(productProvider.productImage),
                        ),
                )
              ],
            ),
          ),
          Visibility(
              visible: productProvider.productImage != null,
              child: TextButton(
                onPressed: (){
                  showModalBottomSheet(context: context, builder: (BuildContext bc) {
                    return Container(
                      child: new Wrap(
                        children: [
                          new ListTile(
                            leading: new Icon(Icons.image),
                            title: new Text('From gallery'),
                            onTap: () async {
                              productProvider.getImageFile(source: ImageSource.gallery);
                              Navigator.pop(context);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.camera_alt),
                            title: new Text('Take a photo'),
                            onTap: () async {
                              productProvider.getImageFile(source: ImageSource.camera);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  });
                },
                child: CustomText(
                  text: "Change Image",
                  color: Colors.purple,
                ),
              ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(text: "featured Magazine"),
                Switch(
                  value: productProvider.featured,
                  onChanged: (value) {
                    productProvider.changeFeatured();
                  },
                )
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                  text: "Category: ",
                  color: Colors.grey,
                  weight: FontWeight.w300,
              ),
              DropdownButton<String>(
                value: categoryProvider.selectedCategory,
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w300
                ),
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.purple,
                ),
                elevation: 0,
                onChanged: (value) {
                  categoryProvider.changeSelectedCategory(
                    newCategory: value.trim()
                  );
                },
                items: categoryProvider.categoriesNames.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                  );
                }).toList(),
              )
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(2, 7),
                    blurRadius: 7
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Product name",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(2, 7),
                    blurRadius: 7
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.description,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Product Description",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18)
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(2, 7),
                    blurRadius: 7
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Price",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18)
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                border: Border.all(color: Colors.black, width: 0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: Offset(2, 7),
                    blurRadius: 4
                  )
                ]
              ),
              child: TextButton(
                onPressed: () async {
                  appProvider.changeLoading();
                  if(!await productProvider.uploadProduct(
                    category: categoryProvider.selectedCategory,
                    //restaurantId: userProvider.restaurant.id,
                    //restaurant: userProvider.restaurant.name
                  )) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Upload Failed"),
                      duration: const Duration(seconds: 10),
                    ));
                    appProvider.changeLoading();
                    return;
                  }
                  productProvider.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Upload Completed"),
                    duration: const Duration(seconds: 10),
                  ));
                 // userProvider.loadProducts();
                  await userProvider.reload();
                  appProvider.changeLoading();
                },
                child: CustomText(
                  text: "Post",
                  color: Colors.white,
                ),
              ),
            ),
          )






        ],
      ),
    );
  }
}
