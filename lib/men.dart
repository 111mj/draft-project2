import 'package:flutter/material.dart';
import 'menProducts.dart';

class Men extends StatefulWidget {
  const Men({super.key});

  @override
  State<Men> createState() => _MenState();
}

class _MenState extends State<Men> {

  bool _load = false; // used to show products list or progress bar

  void update(bool success) {
    setState(() {
      _load = true; // show product list
      if (!success) { // API request failed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }

  @override
  void initState() {
    // update data when the widget is added to the tree the first tome.
    updateMenProducts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(onPressed: !_load ? null : () {
            setState(() {
              _load = false; // show progress bar
              updateMenProducts(update); // update data asynchronously
            });
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart), color: Colors.black,)
        ],
        title: const Text('MEN', style: TextStyle(fontSize: 30,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:  _load ? const ShowMenProducts() : const Center(
          child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
      ),
    );
  }
}
