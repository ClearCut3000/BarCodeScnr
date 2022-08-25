//
//  ScannerVC.swift
//  BarCodeScnr
//
//  Created by Николай Никитин on 25.08.2022.
//

import AVFoundation
import UIKit

enum CameraError: String {
  case invalidDevice = "Unable to permit video device."
  case invalidDeviceInput = "Unable to capture the input."
  case cantAddInput = "Can’t add an input to a capture session."
  case cantAddOutput = "A given output can be added to the session."
  case previewLayerError = "Error with a layer that displays the video as it’s captured."
  case invalidScanedValue = "Unadle to find EAN-8 or EAN-13 codes."
}

protocol ScannerVCDelegate: AnyObject {
  func didFind(barcode: String)
  func didSurface(error: CameraError)
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

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCaptureSession()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    guard let previewLayer = previewLayer else {
      scannerDelegate.didSurface(error: CameraError.previewLayerError)
      return
    }
    previewLayer.frame = view.layer.bounds
  }

  //MARK: - Methods
  private func setupCaptureSession() {
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
      scannerDelegate.didSurface(error: CameraError.invalidDevice)
      return
    }

    let videoInput: AVCaptureDeviceInput
    do {
      try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      scannerDelegate.didSurface(error: CameraError.invalidDeviceInput)
      return
    }

    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      scannerDelegate.didSurface(error: CameraError.cantAddInput)
      return
    }

    let metaDataOutput = AVCaptureMetadataOutput()
    if captureSession.canAddOutput(metaDataOutput) {
      captureSession.addOutput(metaDataOutput)
      metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metaDataOutput.metadataObjectTypes = [.ean13, .ean8]
    } else {
      scannerDelegate.didSurface(error: CameraError.cantAddOutput)
      return
    }

    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    guard let previewLayer = previewLayer else {
      scannerDelegate.didSurface(error: CameraError.previewLayerError)
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
      scannerDelegate.didSurface(error: CameraError.invalidScanedValue)
      return
    }
    guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
      scannerDelegate.didSurface(error: CameraError.invalidScanedValue)
      return
    }
    guard let barcode = machineReadableObject.stringValue else {
      scannerDelegate.didSurface(error: CameraError.invalidScanedValue)
      return
    }
    scannerDelegate.didFind(barcode: barcode)
  }
}
