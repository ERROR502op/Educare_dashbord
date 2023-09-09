import 'package:flutter/material.dart';

class MessageToParent extends StatefulWidget {
  const MessageToParent({super.key});

  @override
  State<MessageToParent> createState() => _MessageToParentState();
}

class _MessageToParentState extends State<MessageToParent> {
  // List to store messages
  List<String> messages = [];

  // Selected parent (defaulting to father)
  String selectedParent = 'Father';

  // Controller for text input
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Radio(
                  value: 'Father',
                  groupValue: selectedParent,
                  onChanged: (value) {
                    setState(() {
                      selectedParent = value!;
                    });
                  },
                ),
                Text('Father'),
                Radio(
                  value: 'Mother',
                  groupValue: selectedParent,
                  onChanged: (value) {
                    setState(() {
                      selectedParent = value!;
                    });
                  },
                ),
                Text('Mother'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      setState(() {
                        messages.add('${selectedParent}: ${messageController.text}');
                        messageController.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          messages.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}