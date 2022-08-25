//
//  BarcodeScannerViewModel.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import SwiftUI

final class BarCodeScannerViewModel: ObservableObject {

  @Published var scannedCode = ""
  @Published var alertItem: AlertItem?

  var statusText: String {
    scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
  }

  var statusTextColor: Color {
    scannedCode.isEmpty ? .red : .green
  }
  
}
