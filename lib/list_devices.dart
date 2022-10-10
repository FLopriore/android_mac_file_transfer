import 'package:android_mac_file_transfer/push_pull_files.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_page_route.dart';
import 'available_devices.dart';

class ListDevice extends StatefulWidget {
  const ListDevice({Key? key}) : super(key: key);

  @override
  State<ListDevice> createState() => _ListDeviceState();
}

/// [_noDevicesAttached] checks if there aren't any attached devices.
/// [_selectedDeviceIndex] is the index of the selected device.
class _ListDeviceState extends State<ListDevice> {
  final bool _noDevicesAttached = AvailableDevices.availableDevicesList.isEmpty;
  int _selectedDeviceIndex = 0;
  String listFiles = "Waiting...";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Available devices",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 250,
            width: 250,
            child: Material(
              color: const Color(0xff3a3a3c),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(height: 1),
                itemCount: AvailableDevices.availableDevicesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                        AvailableDevices.availableDevicesList.elementAt(index)),
                    selected: index == _selectedDeviceIndex,
                    onTap: () {
                      setState(() {
                        _selectedDeviceIndex = index;

                        // put the serial number into selectedDevice
                        AvailableDevices.selectedDevice = AvailableDevices
                            .availableDevicesList
                            .elementAt(index);
                      });
                    },
                    trailing: Icon(
                      (_selectedDeviceIndex == index)
                          ? CupertinoIcons.checkmark_alt_circle_fill
                          : CupertinoIcons.checkmark_alt_circle,
                    ),
                  );
                },
              ),
            ),
          ),
          CupertinoButton.filled(
            onPressed: _noDevicesAttached ? null : _pushConnect,
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }

  Future<void> getFilesList(String path) async {
    String s = "-s ${AvailableDevices.selectedDevice}";
    final arguments = {
      'command': "$s shell ls $path"
    };
    final String availFiles = await AvailableDevices.adbChannel
        .invokeMethod('getAdbCommand', arguments);
    setState(() => listFiles = availFiles);
    AvailableDevices.createFilesList(listFiles);
  }

  void _pushConnect() {
    getFilesList("/storage/emulated/0").then((value) => Navigator.push(context, CustomPageRoute(child: const PushPullFiles())));
  }
}
