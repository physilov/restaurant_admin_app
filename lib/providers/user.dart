import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_admin_app/models/cart_item.dart';
import 'package:restaurant_admin_app/models/restaurant.dart';

import 'package:restaurant_admin_app/models/order.dart';
import 'package:restaurant_admin_app/models/products.dart';
import 'package:restaurant_admin_app/services/order.dart';
import 'package:restaurant_admin_app/services/products.dart';



enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  OrderServices _orderServices = OrderServices();
  ProductServices _productServices = ProductServices();
  double _totalSales = 0;

  RestaurantModel _restaurant;

  List<ProductModel> products = <ProductModel>[];
  List<CartItemModel> cartItems = [];


  Status get status => _status;
  User get user => _user;
  double get totalSales => _totalSales;
  RestaurantModel get restaurant => _restaurant;


  List<OrderModel> orders = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }



  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('restaurants').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'id': result.user.uid,
          "avgPrice": 0.0,
          "image": "",
          "popular": false,
          "rates": 0,
          "rating": 0.0,
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      products = await _productServices.getProducts();
      await getOrders();
      await getTotalSales();
     // await getAvgPrice();
    //  _restaurant = await _restaurantServices.getRestaurantById(id: user.uid);
    }
    notifyListeners();
  }

/*
  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
*/

  void clearController() {
    name.text = " ";
    password.text = " ";
    email.text = " ";
    phone.text = " ";
  }

  getOrders() async {
    orders = await _orderServices.restaurantOrders();
    notifyListeners();
  }

  getTotalSales() async {
    for (OrderModel order in orders) {
      for (CartItemModel item in order.cart) {
          _totalSales = _totalSales + item.price;
          cartItems.add(item);

      }
    }
    _totalSales = _totalSales / 100;
    notifyListeners();
  }


  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    print("The PRODUCT IS: ${cartItem.toString()}");

    try {
    //  _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THe ERROR ${e.toString()}");
      return false;
    }
  }

  bool _onError(String error) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("We got an error: $error");
    return false;
  }

  Future loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future<void> reload() async {
    await loadProducts();
    await getOrders();
    await getTotalSales();
    notifyListeners();
  }

}