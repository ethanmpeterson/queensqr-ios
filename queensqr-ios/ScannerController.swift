//
//  ScannerController.swift
//  queensqr-ios
//
//  Created by Ethan Peterson on 2019-02-17.
//  Copyright © 2019 Ethan Peterson. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var videoPreview: UIView!
    
    var qrText = String()
    
    var captureSession:AVCaptureSession!
    var videoPreviewLayer:AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView!
    
    enum error: Error {
        case noCamera
        case videoInitFailure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Scanner"
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            captureSession = AVCaptureSession()
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            videoPreview.layer.addSublayer(videoPreviewLayer!)
            
            captureSession!.startRunning()
            
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
            
        } catch {
            print("scan failure")
        }
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                //print(metadataObj.stringValue)
                qrText = metadataObj.stringValue!
                // perform segue
                performSegue(withIdentifier: "openQR", sender: nil)
                captureSession.stopRunning()
                //messageLabel.text = metadataObj.stringValue
            }
        }
    }
    
//    func metadataOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects:[Any]!, from connection: AVCaptureConnection) {
//        if metadataObjects.count > 0 {
//            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
//            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
//                qrText = machineReadableCode.stringValue!
//                print(qrText)
//                performSegue(withIdentifier: "openQR", sender: nil)
//            }
//
//        }
//    }
    
//    func scanQR() throws {
//        let captureSession = AVCaptureSession()
//
//        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
//            print("no camera")
//            throw error.noCamera
//        }
//
//        guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else {
//            print("camera init failure")
//            throw error.videoInitFailure
//        }
//
//        let captureMetaDataOutput = AVCaptureMetadataOutput()
//        captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//
//        captureSession.addInput(captureInput)
//        captureSession.addOutput(captureMetaDataOutput)
//
//        captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//
//        let captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        captureVideoPreviewLayer.frame = videoPreview.bounds
//
//        self.videoPreview.layer.addSublayer(captureVideoPreviewLayer)
//        captureSession.startRunning()
//
//
//    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is BuildingViewController {
            let dest = segue.destination as! BuildingViewController
            dest.qrData = qrText
        }
    }

}
