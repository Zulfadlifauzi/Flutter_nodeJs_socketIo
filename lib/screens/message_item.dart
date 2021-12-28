import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.sentByMe, required this.message})
      : super(key: key);

  final bool sentByMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: sentByMe ? Colors.purple : Colors.white,
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 18, color: sentByMe ? Colors.white : Colors.purple),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '1:10 AM',
              style: TextStyle(
                fontSize: 10,
                color:
                    (sentByMe ? Colors.white : Colors.purple).withOpacity(0.7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
