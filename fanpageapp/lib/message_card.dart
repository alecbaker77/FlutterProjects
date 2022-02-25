import 'package:flutter/material.dart';
import 'package:fanpageapp/diary_entry_button.dart';
import 'package:fanpageapp/message_card.dart';
import 'package:fanpageapp/top_bar_title.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/pop_up_menu.dart';
import 'package:fanpageapp/diary_entry_page.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.diaryEntry,
  }) : super(key: key);

  final DiaryEntry diaryEntry;

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
                              diaryEntry.body,
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
                    Spacer(),
                    Divider(thickness: 1),
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
                                return DiaryEntryPage.read(
                                  diaryEntry: diaryEntry,
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