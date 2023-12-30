import 'package:flutter/material.dart';
import 'package:project2/men.dart';
import 'package:project2/wishlist.dart';
import 'women.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 120,
            child: DrawerHeader(
                child: Column(
                  children: [
                    TextField(),
                    SizedBox(height: 10,),
                    ElevatedButton(onPressed: null, child: Text('SEARCH'),)
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
            title: const Text('BEAUTY', style: TextStyle(fontSize: 20),),
            onTap: () => {},
          ),
          ListTile(
            title: const Text('HOMEWARE', style: TextStyle(fontSize: 20),),
            onTap: () => {},
          ),
          ListTile(
            title: const Text('TOYS', style: TextStyle(fontSize: 20),),
            onTap: () => {},
          ),
          ListTile(
            title: const Text('SALE', style: TextStyle(fontSize: 20),),
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
}
