import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

dynamic currentTime = DateFormat.jm().format(DateTime.now());

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
            color: sentByMe ? Colors.amber : Colors.blue,
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 18, color: sentByMe ? Colors.white : Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              currentTime,
              style: TextStyle(
                fontSize: 10,
                color:
                    (sentByMe ? Colors.white : Colors.white).withOpacity(0.7),
              ),
            )
          ],
        ),
      ),
    );
  }
}
