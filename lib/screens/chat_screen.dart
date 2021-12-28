import 'package:chatappflutter/screens/message_item.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController msgInputController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: Container(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return MessageItem(
                          sentByMe: false,
                        );
                      }),
                )),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.purple,
                controller: msgInputController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(right: 1),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                          onPressed: () {
                            sendMessage(msgInputController);
                            msgInputController.text = '';
                          },
                          icon: const Icon(Icons.send, color: Colors.white)),
                    )),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

void sendMessage(TextEditingController msgInputController) {}
