import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// main URL for REST pages
const String _baseURL = 'csci410mj.000webhostapp.com';

// class to represent a row from the products table
// note: cid is replaced by category name
class Product {
  String _name;
  int _quantity;
  double _price;

  Product(this._name, this._quantity, this._price);

  @override
  String toString() {
    return 'Name: $_name\nQuantity: $_quantity\n Price: \$$_price';
  }
}
// list to hold products retrieved from getProducts
List<Product> _products = [];
// asynchronously update _products list
void updateWomenProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'womenProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 60)); // max timeout 5 seconds
    _products.clear(); // clear old products
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) { // iterate over all rows in the json array
        Product p = Product( // create a product object from JSON row object
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']));
        _products.add(p); // add the product object to the _products list
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  }
  catch(e) {
    update(false); // inform through callback that we failed to get data
  }
}

// shows products stored in the _products list as a ListView
class ShowWomenProducts extends StatelessWidget {
  const ShowWomenProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              color: index % 2 == 0 ? Colors.amber: Colors.cyan,
              padding: const EdgeInsets.all(5),
              width: width * 0.9,
              child: Row(children: [
              SizedBox(width: width * 0.15),
              Flexible(child: Text(_products[index].toString()))
          ]))
        ])
    );
  }
}
