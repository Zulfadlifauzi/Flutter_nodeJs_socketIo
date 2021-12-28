import 'package:chatappflutter/controller/chat_controller.dart';
import 'package:chatappflutter/model/message.dart';
import 'package:chatappflutter/screens/message_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as _io;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msgInputController = TextEditingController();
  late _io.Socket socket;
  ChatController chatController = ChatController();

  @override
  void initState() {
    socket = _io.io(
        'http://localhost:4000',
        _io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    setUpSocketListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Obx(
              () => Container(
                height: 40,
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.amber,
                child: Text(
                  'Connected User ${chatController.connectedUser}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            Expanded(
                flex: 9,
                child: Obx(
                  () => ListView.builder(
                      itemCount: chatController.chatMessages.length,
                      itemBuilder: (context, index) {
                        var currentItem = chatController.chatMessages[index];
                        return MessageItem(
                          sentByMe: currentItem.sentByMe == socket.id,
                          message: currentItem.message.toString(),
                        );
                      }),
                )),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.purple,
                      controller: msgInputController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )),
                  Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                        onPressed: () {
                          sendMessage(msgInputController.text);
                          msgInputController.text = '';
                        },
                        icon: const Icon(Icons.send, color: Colors.white)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) {
    var messageJson = {'message': text, 'sentByMe': socket.id};

    socket.emit('message', messageJson);
    chatController.chatMessages.add(Message.fromJson(messageJson));
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      print(data);
      chatController.chatMessages.add(Message.fromJson(data));
    });
    socket.on('connected-user', (data) {
      print(data);
      chatController.connectedUser.value = data;
    });
  }
}
