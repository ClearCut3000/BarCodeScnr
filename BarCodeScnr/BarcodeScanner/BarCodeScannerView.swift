//
//  BarCodeScannerView.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import SwiftUI

struct BarCodeScannerView: View {

  //MARK: - Property
  @StateObject var viewModel = BarCodeScannerViewModel()

  //MARK: - Main View
  var body: some View {
    NavigationView {
      VStack {
        ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
          .frame(maxHeight: 300)
        Spacer().frame(height: 60)
        Label("Scanned Barcode", systemImage: "barcode.viewfinder")
          .font(.title)
        Text(viewModel.statusText)
          .bold()
          .font(.largeTitle)
          .foregroundColor(viewModel.statusTextColor)
          .padding()
      }
      .navigationTitle("BarCode Scanner!")
      .alert(item: $viewModel.alertItem) { alertItem in
        Alert(title: alertItem.title,
              message: alertItem.message,
              dismissButton: alertItem.dismissButton)
      }
    }
  }
}

struct BarCodeScannerView_Previews: PreviewProvider {
  static var previews: some View {
    BarCodeScannerView()
  }
}
