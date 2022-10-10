import 'dart:core';

import 'package:android_mac_file_transfer/list_devices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_page_route.dart';
import 'available_devices.dart';

class FindDevices extends StatefulWidget {
  const FindDevices({Key? key}) : super(key: key);

  @override
  State<FindDevices> createState() => _FindDevicesState();
}

class _FindDevicesState extends State<FindDevices> {
  String adbDevices = "Waiting...";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Easily transfer files\nbetween\nAndroid and Mac",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          CupertinoButton.filled(
            onPressed: _pushFindDevices,
            child: const Text('Find devices'),
          ),
        ],
      ),
    );
  }

  Future<void> getAdbCommand() async {
    final arguments = {'command': 'devices'};
    final String availAdbDevices =
        await AvailableDevices.adbChannel.invokeMethod('getAdbCommand', arguments);
    setState(() => adbDevices = availAdbDevices);
    AvailableDevices.createAdbDevicesList(adbDevices);
  }

  void _pushFindDevices() {

    getAdbCommand().then((value) =>
        Navigator.of(context).push(CustomPageRoute(child: ListDevice())));
  }
}
