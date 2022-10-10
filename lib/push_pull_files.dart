import 'package:android_mac_file_transfer/folder_mac_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TransferDirection { phoneToMac, macToPhone }

class PushPullFiles extends StatefulWidget {
  const PushPullFiles({Key? key}) : super(key: key);

  @override
  State<PushPullFiles> createState() => _PushPullFilesState();
}

/// [_selectedIndex] is the index of the selected option. If [_selectedIndex]
/// equals 0, you transfer files from Mac to your phone, if it equals 1 from
/// your phone to Mac.
/// [_icons] contains the 2 possible icons, [CupertinoIcons.arrow_up_circle]
/// when you transfer files to your phone and [CupertinoIcons.arrow_down_circle]
/// when you do to your Mac.
class _PushPullFilesState extends State<PushPullFiles> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    CupertinoIcons.arrow_up_circle,
    CupertinoIcons.arrow_down_circle
  ];

  /// It returns the name of the action depending on the index.
  /// [index] is the index of each ListTile in the side bar.
  String _getActionName(int index) {
    return (index == 0) ? "Copy to phone" : "Copy to Mac";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: const Color(0x00282830),
      child: Row(
        children: [
          Container(
              width: 250,
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Material(
                color: const Color(0x00282830),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: ListTile(
                        leading: Icon(
                          _icons[index],
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        selectedTileColor: CupertinoColors.activeBlue,
                        title: Text(
                          _getActionName(index),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        selected: index == _selectedIndex,
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              )),
          FolderMacPath(optionIndex: _selectedIndex),
        ],
      ),
    );
  }
}
