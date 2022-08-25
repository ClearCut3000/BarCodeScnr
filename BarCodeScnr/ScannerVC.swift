//
//  ScannerVC.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import AVFoundation
import UIKit

protocol ScannerVCDelegate: AnyObject {
  func didFind(barcode: String)
}

final class ScannerVC: UIViewController {

  //MARK: Properties
  let captureSession = AVCaptureSession()
  var previewLayer: AVCaptureVideoPreviewLayer?
  weak var scannerDelegate: ScannerVCDelegate!

  //MARK: - Init's
  init(scannerDelegate: ScannerVCDelegate) {
    super.init(nibName: nil, bundle: nil)
    self.scannerDelegate = scannerDelegate
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Methods
  private func setupCaptureSession() {
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
      return
    }
    let videoInput: AVCaptureDeviceInput
    do {
      try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      return
    }
    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      return
    }
    let metaDataOutput = AVCaptureMetadataOutput()
    if captureSession.canAddOutput(metaDataOutput) {
      captureSession.addOutput(metaDataOutput)
      metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metaDataOutput.metadataObjectTypes = [.ean13, .ean8]
    } else {
      return
    }
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    guard let previewLayer = previewLayer else {
      return
    }
    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)
    captureSession.startRunning()
  }
}

//MARK: - MetaData Output Extension
extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    guard let object = metadataObjects.first else {
      return
    }
    guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
      return
    }
    guard let barcode = machineReadableObject.stringValue else {
      return
    }
    scannerDelegate.didFind(barcode: barcode)
  }
}
