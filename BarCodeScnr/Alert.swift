//
//  Alert.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: String
  let message: String
  let dismissButton: Alert.Button
}

struct AlertContext {
  static let invalidDevice = AlertItem(title: "Can't access to capture device!",
                                       message: "Unable to permit video device.",
                                       dismissButton: .default(Text("OK")))
  static let invalidDeviceInput = AlertItem(title: "Invalid device input!",
                                            message: "Unable to capture the input.",
                                            dismissButton: .default(Text("OK")))
  static let cantAddInput = AlertItem(title: "Can't add device input!",
                                      message: "Can’t add an input to a capture session.",
                                      dismissButton: .default(Text("OK")))
  static let cantAddOutput = AlertItem(title: "Can't add device output!",
                                       message: "A given output can be added to the session.",
                                       dismissButton: .default(Text("OK")))
  static let previewLayerError = AlertItem(title: "Preview error!",
                                           message: "Error with a layer that displays the video as it’s captured.",
                                           dismissButton: .default(Text("OK")))
  static let invalidScanedValue = AlertItem(title: "Can't recognize a code!",
                                            message: "Unadle to find EAN-8 or EAN-13 codes.",
                                            dismissButton: .default(Text("OK")))
}
