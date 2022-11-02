import 'package:flutter/material.dart';

import '../models/message.dart';

class BotMessageBubbleWidget extends StatelessWidget {
  const BotMessageBubbleWidget(
      {Key? key,
      required this.message,
      required this.isSent,
      required this.isDelivered,
      required this.isSeen})
      : super(key: key);

  final Message message;

  final bool isSent;
  final bool isDelivered;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment:
            (message.userId == 'bot') ? Alignment.topLeft : Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xEEFDFDFD),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextMessage(),
              const SizedBox(height: 15),
              _buildBottomRow(),
            ],
          ),
        ));
  }

  Widget _buildTextMessage() {
    return Text(
      message.text,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        color: Color(0xFF3A3A3A),
      ),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          '12:00',
          style: TextStyle(
            color: Color(0xFF97AD8E),
            fontSize: 12,
          ),
        ),
        SizedBox(width: 5),
        Icon(
          Icons.done_all,
          size: 18,
          color: Color(0xFF97AD8E),
        ),
      ],
    );
  }
}
