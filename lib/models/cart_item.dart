import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel{
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";

  String _id;
  String _name;
  String _image;
  int _price;
  String _productId;
  int _quantity;
  int _date;


  String get id => _id;
  String get name => _name;
  String get image => _image;
  int get price => _price;
  int get quantity => _quantity;
  String get productId => _productId;
  int get date => _date;


  CartItemModel.fromMap(Map data){
    _id = data[ID];
    _name = data[NAME];
    _price = data[PRICE];
    _image = data[IMAGE];
    _quantity = data[QUANTITY];
    _productId = data[PRODUCT_ID];
    _date = DateTime.daysPerWeek;
  }

  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    PRICE: _price,
    QUANTITY: _quantity,
    PRODUCT_ID: _productId,
  };

}
