import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const DESCRIPTION = "description";
  static const RATES = "rates";
  static const USER_LIKES = "userlikes";

  String _id;
  String _name;
  double _rating;
  String _image;
  String _description;
  double _price;
  String _category;
  bool _featured;
  int _rates;


  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get description => _description;
  double get rating => _rating;
  double get price => _price;
  int get rates => _rates;
  bool get featured => _featured;
  String get category => _category;
  bool liked = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _rating = snapshot.data()[RATING];
    _price = snapshot.data()[PRICE];
    _image = snapshot.data()[IMAGE];
    _description = snapshot.data()[DESCRIPTION];
    _rates = snapshot.data()[RATES];
    _featured = snapshot.data()[FEATURED];
    _category = snapshot.data()[CATEGORY];
  }

}
