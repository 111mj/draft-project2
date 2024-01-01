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
  String _image;

  Product(this._name, this._quantity, this._price, this._image);

}

// list to hold products retrieved from getProducts
List<Product> _products = [];
// asynchronously update _products list
void updateMenProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'menProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 60)); // max timeout 5 seconds
    _products.clear(); // clear old products
    if (response.statusCode == 200) {
      // if successful call
      final jsonResponse = convert
          .jsonDecode(response.body); // create dart json object from json array
      for (var row in jsonResponse) {
        Product p = Product(
            row['name'],
            int.parse(row['quantity']),
            double.parse(row['price']),
            row['image']);
        _products.add(p);
      }
      update(true); // callback update method to inform that we completed retrieving data
    }
  } catch (e) {
    update(false); // inform through callback that we failed to get data
  }
}

// shows products stored in the _products list as a ListView
class ShowMenProducts extends StatelessWidget {
  const ShowMenProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) => Column(children: [
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black87),
                  //color: Colors.black87,//index % 2 == 0 ? Colors.amber : Colors.cyan,
                  padding: const EdgeInsets.all(5),
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Column(children: [
                      Image.asset(_products[index]._image, height: 100,)
                    ]),
                    Column(children: [
                      Text(_products[index]._name, style: TextStyle(fontSize: width * 0.045, color: Colors.white)),
                    ]),
                    Column(
                      children: [
                        Text('\$${_products[index]._price.toStringAsFixed(0)}', style: TextStyle(fontSize: width * 0.045, color: Colors.white)),
                      ],
                    ),
                    ElevatedButton(onPressed: (){}, child: const Icon(Icons.star))
                    //Radio(value: value, groupValue: groupValue, onChanged: () {})
                  ])
              )
            ])
    );
  }
}
