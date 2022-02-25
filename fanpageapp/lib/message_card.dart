import 'package:flutter/material.dart';
import 'package:fanpageapp/message_entry_model.dart';
import 'package:fanpageapp/message_entry_page.dart';


class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.messageEntry,
  }) : super(key: key);

  final MessageEntry messageEntry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35.0),
      child: SizedBox(
        height: 250,
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 30, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              messageEntry.body,
                              maxLines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2,
                                  //.copyWith(height: 1.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MessageEntryPage.read(
                                  messageEntry: messageEntry,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Read more',
                          style: TextStyle(
                            color: Colors.lightBlue.shade300,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}