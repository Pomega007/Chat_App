import 'package:flutter/material.dart';
import 'ChatScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
                horizontal: 0
          ),
          child: Column(
            children: [
              SizedBox(
                width: 600,
                height: 350,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.zero,
                            topRight: Radius.zero,
                            topLeft: Radius.zero),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: <Color>[
                            Colors.deepOrange,
                            Colors.orange.shade500,
                            Colors.orange.shade200
                          ],
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 50,),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                    label: Text('Enter your name'),
                  fillColor: Colors.white
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'field is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          name: nameController.text,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
