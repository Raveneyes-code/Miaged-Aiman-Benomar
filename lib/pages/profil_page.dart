import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:miagedv1/pages/login_page.dart';
import 'package:miagedv1/pages/signup_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _birthdayController;
  late TextEditingController _addressController;
  late TextEditingController _postalCodeController;
  late TextEditingController _cityController;
  bool _isEditing = false;
  late String _userId;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _birthdayController = TextEditingController();
    _addressController = TextEditingController();
    _postalCodeController = TextEditingController();
    _cityController = TextEditingController();

    _userId = 'jjf0SuoR8iS3LcjakIWl';

    FirebaseFirestore.instance.collection('users').doc(_userId).get().then((doc) {
      final data = doc.data() as Map<String, dynamic>;
      _nameController.text = data['name'];
      _emailController.text = data['email'];
      _passwordController.text = data['password'];
      _addressController.text = data['address'];
      _birthdayController.text = data['birthday'];
      _postalCodeController.text = data['postalCode'];
      _cityController.text = data['city'];

    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/seed/myUserId/200'),
              radius: 70.0,
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
              enabled: _isEditing,
            ), //name
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
              enabled: _isEditing,
            ), //email
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true, // to hide the password
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
              enabled: _isEditing,
            ), //password
            const SizedBox(height: 10),
            TextFormField(
              controller: _addressController,

              decoration: InputDecoration(
                labelText: 'Address',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
              enabled: _isEditing,
            ), //adress
            const SizedBox(height: 10),
            TextFormField(
              controller: _birthdayController,
              keyboardType: TextInputType.datetime,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'\d{2}/\d{2}/\d{4}')),
                // This formatter will automatically add slashes between the date components
                // as the user types. You could also use a DateTextInputFormatter to enforce a
                // specific date format.
              ],
              decoration: InputDecoration(
                labelText: 'Birthday',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
              enabled: _isEditing,
            ), //birthday
            // const SizedBox(height: 10),
            // TextFormField(
            //   controller: _postalCodeController,
            //   keyboardType: TextInputType.datetime,
            //   decoration: InputDecoration(
            //     labelText: 'Postal code',
            //     labelStyle: const TextStyle(color: Colors.black),
            //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(20),
            //       borderSide: const BorderSide(color: Colors.grey),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(20),
            //       borderSide: const BorderSide(color: Colors.black),
            //     ),
            //   ),
            //   style: const TextStyle(color: Colors.black),
            //   enabled: _isEditing,
            // ),
            ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: const Icon(Icons.arrow_back, size: 32,),
                label: const Text('Sign Out')
            ),

            const SizedBox(height: 30),
            IconButton(
              icon: Icon(_isEditing ? Icons.check : Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });

                if (!_isEditing) {
                  FirebaseFirestore.instance.collection('users').doc(_userId).update({
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'password':_passwordController.text,
                    'address':_addressController.text,
                    'birthday':_birthdayController.text,
                    'postalCode':_postalCodeController.text,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated!')));
                }
              },
              color: Colors.black,
            ),


          ],
        ),
      ),
    );
  }
}
