import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatScreen extends StatefulWidget {
  String? name;

  ChatScreen({
    required this.name,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Instance (FireStore)
  final fireStore = FirebaseFirestore.instance;

  final String collectionName = 'Chat';

  TextEditingController msgController = TextEditingController();

  addMsg() {
    fireStore.collection(collectionName).add({
      'Msg': msgController.text,
      'SenderID': widget.name,
    });
    msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection(collectionName).snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? chatBody(snapshot.data)
              : snapshot.hasError
              ? Text('ERROR')
              : Center(
            child: LoadingAnimationWidget.beat(color: Colors.black, size: 100),
          );
        },
      ),
    );
  }

  Widget chatBody(dynamic data) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      child: Column(
        children: [
          SizedBox(
            width: 650,
            height: 100,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
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
                    'Chat Screen',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),

                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView.builder(
              itemCount: data.docs.length,
              reverse: true,
              itemBuilder: (context, index) {
                return Align(
                  alignment: widget.name == data.docs[index]['SenderID']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(data.docs[index]['Msg'] ?? '',),
                );
              },
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: msgController,
                      decoration: InputDecoration(
                        label: Text('Enter your Message'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.red)
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          addMsg();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}