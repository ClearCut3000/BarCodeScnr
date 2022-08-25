//
//  BarCodeScannerView.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import SwiftUI

struct BarCodeScannerView: View {
  var body: some View {
    NavigationView {
      VStack {
        Rectangle()
          .frame(maxWidth: .infinity, maxHeight: 300)
        Spacer().frame(height: 60)
        Label("Scanned Barcode", systemImage: "barcode.viewfinder")
          .font(.title)
        Text("Not Yet Scanned")
          .bold()
          .font(.largeTitle)
          .foregroundColor(.red)
          .padding()
      }
      .navigationTitle("BarCode Scanner!")
    }
  }
}

struct BarCodeScannerView_Previews: PreviewProvider {
  static var previews: some View {
    BarCodeScannerView()
  }
}
