import 'package:flutter/services.dart';

class AvailableDevices {
  static final availableDevicesList = <String>{}; // list of attached devices
  static final availableFilesList = <String>{}; // list of files in a specific path
  static String selectedDevice = availableDevicesList.first;
  static final selectedFilesList = <String>{}; // list of selected files and folders
  static const adbChannel = MethodChannel('com.flopriore/adb');// serial number of the selected device

  /// It extracts all the attached devices with the command "adb devices" and
  /// adds them in [availableDevicesList].
  /// [adbDevices] is the output of "adb devices" command.
  static void createAdbDevicesList(String adbDevices) {
    // remove "List of devices attached" from adbDevices
    adbDevices = adbDevices.substring(25);
    const String end = "device";
    while (adbDevices != "\n") {
      final int endIndex = adbDevices.indexOf(end);
      String deviceSerial =
          adbDevices.substring(0, endIndex); // serial number of the device

      // add the serial number of the device to availableDevicesList
      availableDevicesList.add(deviceSerial);

      String remainingDevices =
          adbDevices.substring(endIndex + end.length + 1); // remaining string

      adbDevices = remainingDevices;
    }
  }

  static void createFilesList(String listFiles) {
    const String end = "\n";
    while (listFiles.isNotEmpty) {
      final int endIndex = listFiles.indexOf(end);
      String name =
      listFiles.substring(0, endIndex); // name of the folder or file

      // add the folder or the file to availableFilesList
      availableFilesList.add(name);

      String remainingFiles =
      listFiles.substring(endIndex + end.length); // remaining string

      listFiles = remainingFiles;
    }
  }
}
