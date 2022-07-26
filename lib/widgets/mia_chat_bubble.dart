import 'package:flutter/material.dart';
import 'package:homemedica_patient/models/mia_message_model.dart';
import 'package:homemedica_patient/widgets/bubble_text.dart';

class MiaChatBubble extends StatelessWidget {
  final MiaMessageModel message;
  final bool isFromAi;
  final bool withoutAvatar;
  MiaChatBubble({
    required this.message,
    required this.isFromAi,
    required this.withoutAvatar,
  }) : super();

  Widget chatItem(BuildContext context) {
    return Container(
      alignment: isFromAi ? Alignment.centerLeft : Alignment.centerRight,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
            return isFromAi
                ? _PeerMessage(
              isMe: !isFromAi,
              message: message,
              constraints: constraints,
              withoutAvatar: withoutAvatar,
            )
                : _WithoutAvatar(
              isMe: !isFromAi,
              message: message,
              constraints: constraints,
            );

          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return chatItem(context);
  }
}

class _PeerMessage extends StatelessWidget {
  const _PeerMessage({
    Key? key,
    required this.isMe,
    required this.message,
    required this.constraints,
    required this.withoutAvatar,
  }) : super(key: key);

  final bool isMe;
  final MiaMessageModel message;
  final BoxConstraints constraints;
  final bool withoutAvatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 30),
        _WithoutAvatar(
          isMe: isMe,
          message: message,
          constraints: constraints,
        ),
      ],
    );
  }
}

class _WithoutAvatar extends StatelessWidget {
  const _WithoutAvatar({
    Key? key,
    required this.isMe,
    required this.message,
    required this.constraints,
  }) : super(key: key);

  final bool isMe;
  final MiaMessageModel message;
  final BoxConstraints constraints;

  BorderRadius _replyMsgRadius() {
      if (isMe)
        return BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        );
      return BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
      );

  }

  @override
  Widget build(BuildContext context) {

    return Wrap(
      children: [
        Stack(
          children: [
            Align(
              alignment: isMe? Alignment.bottomRight:Alignment.bottomLeft,
              child: Container(
                // key: key,
                margin: const EdgeInsets.all(0),
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth * 0.8,
                ),
                decoration: BoxDecoration(
                  borderRadius: _replyMsgRadius(),
                  border: isMe ? null : Border.all(color: Colors.black54),
                  color: isMe ? Colors.black54 : Colors.pink[500],
                ),
                child: Padding(
                  key: key,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runAlignment: WrapAlignment.end,
                    alignment: WrapAlignment.end,
                    spacing: 20,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 12),
                        child: BubbleText(text: message.message),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}