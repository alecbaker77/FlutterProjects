import 'package:flutter/material.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/diary_entry_page.dart';


class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key? key,
    required this.diaryEntry,
  }) : super(key: key);
  final DiaryEntry diaryEntry;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
      elevation: 2,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Action.edit,
            child: Text('Edit'),
          ),
        ];
      },
      onSelected: (action) {
        switch (action) {
          case Action.edit:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return DiaryEntryPage.edit(
                    diaryEntry: diaryEntry,
                  );
                },
              ),
            );
            break;

          default:
        }
      },
    );
  }
}

enum Action { delete, edit, none }
