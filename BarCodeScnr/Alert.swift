//
//  Alert.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: Text
  let message: Text
  let dismissButton: Alert.Button
}

struct AlertContext {
  static let invalidDevice = AlertItem(title: Text("Can't access to capture device!"),
                                       message: Text("Unable to permit video device."),
                                       dismissButton: .default(Text("OK")))
  static let invalidDeviceInput = AlertItem(title: Text("Invalid device input!"),
                                            message: Text("Unable to capture the input."),
                                            dismissButton: .default(Text("OK")))
  static let cantAddInput = AlertItem(title: Text("Can't add device input!"),
                                      message: Text("Can’t add an input to a capture session."),
                                      dismissButton: .default(Text("OK")))
  static let cantAddOutput = AlertItem(title: Text("Can't add device output!"),
                                       message: Text("A given output can be added to the session."),
                                       dismissButton: .default(Text("OK")))
  static let previewLayerError = AlertItem(title: Text("Preview error!"),
                                           message: Text("Error with a layer that displays the video as it’s captured."),
                                           dismissButton: .default(Text("OK")))
  static let invalidScanedValue = AlertItem(title: Text("Can't recognize a code!"),
                                            message: Text("Unadle to find EAN-8 or EAN-13 codes."),
                                            dismissButton: .default(Text("OK")))
}
