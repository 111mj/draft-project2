import 'package:flutter/material.dart';
import 'package:project2/men.dart';
import 'package:project2/search.dart';
import 'package:project2/women.dart';
import 'package:project2/wishlist.dart';
import 'package:project2/product.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {

  final TextEditingController _controllerName = TextEditingController();

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 140,
            child: DrawerHeader(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: 'search for watches'),
                      controller: _controllerName,
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(onPressed: openSearch, child: const Text('SEARCH'),)
                  ],
                )
            ),
          ),
          ListTile(
            title: const Text('WOMEN', style: TextStyle(fontSize: 20),),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Women(),
                  )
              )
            },
          ),
          ListTile(
            title: const Text('MEN', style: TextStyle(fontSize: 20),),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Men(),
                  )
              )
            },
          ),
          ListTile(
            title: const Text('KIDS', style: TextStyle(fontSize: 20),),
            onTap: () => {},
          ),
          ListTile(
            title: const Text('TOYS', style: TextStyle(fontSize: 20),),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('WISHLIST', style: TextStyle(fontSize: 20),),
            onTap: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Wishlist(),
                  )
              )
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('LOGIN/REGISTER', style: TextStyle(fontSize: 20),),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }

  void openSearch() {
    try {
      String name = _controllerName.text;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Search(),
          settings: RouteSettings(arguments: name)));
    } catch (e) {
      const Text('Invalid Arguments');
    }
  }

}
