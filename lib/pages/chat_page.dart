import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:chat_app/widgets/chat_buble_friend.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages
          .orderBy(
            kCreatedAt,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (QueryDocumentSnapshot document in snapshot.data!.docs) {
            messagesList
                .add(Message.fromJson(document.data() as Map<String, dynamic>));
          }

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  constraints: BoxConstraints(maxWidth: 30),
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  constraints: BoxConstraints(maxWidth: 40),
                  icon: Icon(Icons.more_vert),
                )
              ],
              automaticallyImplyLeading:
                  false, //  // Set this to false to remove the arrow back
              backgroundColor: newColor,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Chat ',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(
                              message: messagesList[index],
                            )
                          : ChatBubleForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          'id': email,
                        },
                      );
                      controller.clear();
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Type something...',
                      suffixIcon: Icon(
                        Icons.send,
                        color: newColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: newColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Text('Loading..');
        }
      },
    );
  }
}
