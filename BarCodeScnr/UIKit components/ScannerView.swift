//
//  ScannerView.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

  @Binding var scannedCode: String
  @Binding var alertItem: AlertItem?

  func makeUIViewController(context: Context) -> ScannerVC {
    ScannerVC(scannerDelegate: context.coordinator)
  }

  func updateUIViewController(_ uiViewController: ScannerVC, context: Context) { }


  func makeCoordinator() -> Coordinator {
    return Coordinator(scannerView: self)
  }

  final class Coordinator: NSObject, ScannerVCDelegate {
    private let scannerView: ScannerView

    init(scannerView: ScannerView) {
      self.scannerView = scannerView
    }

    func didFind(barcode: String) {
      scannerView.scannedCode = barcode
    }

    func didSurface(error: CameraError) {
      switch error {
      case .invalidDevice:
        scannerView.alertItem = AlertContext.invalidDevice
      case .invalidDeviceInput:
        scannerView.alertItem = AlertContext.invalidDeviceInput
      case .cantAddInput:
        scannerView.alertItem = AlertContext.cantAddInput
      case .cantAddOutput:
        scannerView.alertItem = AlertContext.cantAddOutput
      case .previewLayerError:
        scannerView.alertItem = AlertContext.previewLayerError
      case .invalidScanedValue:
        scannerView.alertItem = AlertContext.invalidScanedValue
      }
    }
  }
}
