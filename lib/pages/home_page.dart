import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My App'),
//       ),
//       body: Container(
//         child: Column( // Wrap the SizedBox within a Column
//           children: [
//             SizedBox(height: 40),
//             ElevatedButton.icon(
//                 onPressed: ()=> FirebaseAuth.instance.signOut(),
//                 icon: const Icon(Icons.arrow_back, size: 32,),
//                 label: const Text('Sign Out')
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miagedv1/pages/cart/cart_page.dart';
import 'package:miagedv1/pages/detail_page.dart';
import 'package:miagedv1/pages/profil_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _filterOption;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'http://www.miage.fr/wp-content/uploads/2020/02/MIAGE_LOGO-SEUL_COULEURS.png',
                  height: 40.0,
                  fit: BoxFit.contain,
                ),
                IconButton(
                  onPressed: () {
                    _showFilters(context);
                  },
                  icon: const Icon(
                    Icons.filter_list,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _buildQuerySnapshotStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(document),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              document['image'],
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['name'],
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    '\$${document['price']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    'Available in: ${document['sizes']}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.shopping_bag_rounded,
              size: 28.0,
            ),
            label: 'Buy',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_rounded,
              size: 28.0,
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 28.0,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );


  }

  Stream<QuerySnapshot> _buildQuerySnapshotStream() {
    CollectionReference productsCollection =
    FirebaseFirestore.instance.collection('products');
    if (_filterOption == 'name') {
      return productsCollection.orderBy('name').snapshots();
    } else if (_filterOption == 'price') {
      return productsCollection.orderBy('price').snapshots();
    } else {
      return productsCollection.snapshots();
    }
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _filterOption = 'name';
                      });
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.sort_by_alpha),
                    color: _filterOption == 'name'
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _filterOption = 'price';
                      });
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.monetization_on),
                    color: _filterOption == 'price'
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _filterOption = null;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Clear Filters'),
              ),
            ],
          ),
        );
      },
    );
  }
  void _onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  CartPage()),
      );
    } else if(index==2){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ProfilePage()),
      );
    }
    else {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
