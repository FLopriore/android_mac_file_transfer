import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'available_devices.dart';
import 'push_pull_files.dart';

class FolderMacPath extends StatefulWidget {
  late final TransferDirection transferDirection;

  FolderMacPath({Key? key, required int optionIndex}) : super(key: key) {
    if (optionIndex == 0) {
      transferDirection = TransferDirection.macToPhone;
    } else {
      transferDirection = TransferDirection.phoneToMac;
    }
  }

  @override
  State<FolderMacPath> createState() => _FolderMacPathState();
}

class _FolderMacPathState extends State<FolderMacPath> {
  String? selectedDirectory = "~/";
  final TextEditingController _controller = TextEditingController();
  final _selectedFilesIndexes = <int>{}; // list of selected files

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: 550,
      child: Scaffold(
        backgroundColor: const Color(0x00282830),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      //height: 44,
                      width: 400,
                      child: CupertinoTextField(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Color(0xff727274),
                        ),
                        //padding: const EdgeInsets.all(10.0),
                        controller: _controller,
                        placeholder: "Path on Mac",
                        placeholderStyle:
                            const TextStyle(color: Colors.white54),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w300),
                      )),
                ),
                SizedBox(
                  height: 32,
                  child: CupertinoButton.filled(
                      onPressed: _onPressedBrowse,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 18.0),
                      child: const Text("Browse...")),
                )
              ],
            ),
            SizedBox(
              height: 250,
              width: 550,
              child: Material(
                color: const Color(0xff3a3a3c),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: AvailableDevices.availableFilesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedFilesIndexes.contains(index)) {
                            _selectedFilesIndexes.remove(index);
                            AvailableDevices.selectedFilesList.remove(AvailableDevices.availableFilesList.elementAt(index));
                          } else {
                            _selectedFilesIndexes.add(index);
                            AvailableDevices.selectedFilesList.add(AvailableDevices.availableFilesList.elementAt(index));
                          }

                        });
                      },
                      child: ListTile(
                        title: Text(
                            AvailableDevices.availableFilesList.elementAt(index)),
                        selected: _selectedFilesIndexes.contains(index),
                        trailing: Icon(
                          (_selectedFilesIndexes.contains(index))
                              ? CupertinoIcons.checkmark_alt_circle_fill
                              : CupertinoIcons.checkmark_alt_circle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            CupertinoButton.filled(
              onPressed: _onPressedBrowse,
              child: const Text('Copy'),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedBrowse() async {
    selectedDirectory = await FilePicker.platform.getDirectoryPath();
    _controller.value = TextEditingValue(
      text: selectedDirectory!,
      selection: TextSelection.collapsed(
        offset: selectedDirectory!.length,
      ),
    );
  }
}
