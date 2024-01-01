import 'package:flutter/material.dart';
import 'product.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments as String;
    String _text = '';

    void update(String text) {
      setState(() {
        _text = text;
      });
    }

    void getProduct() {
      try {
        searchProduct(update, name); // search asynchronously for product record
      }
      catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('wrong arguments')));
      }
    }

    getProduct();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
        centerTitle: true,
      ),
      body:
        Center(child: SizedBox(width: 200, child: Flexible(child: Text(_text,
            style: const TextStyle(fontSize: 18))))),
    );
  }
}
