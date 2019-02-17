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
    
    enum error: Error {
        case noCamera
        case videoInitFailure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try scanQR()
        } catch {
            print("scan failure")
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects:[Any]!, from connection: AVCaptureConnection) {
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                qrText = machineReadableCode.stringValue!
                // perform segue here
            }
            
        }
    }
    
    func scanQR() throws {
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("no camera")
            throw error.noCamera
        }
        
        guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            print("camera init failure")
            throw error.videoInitFailure
        }
        
        let captureMetaDataOutput = AVCaptureMetadataOutput()
        captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        captureSession.addInput(captureInput)
        captureSession.addOutput(captureMetaDataOutput)
        
        captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let captureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        captureVideoPreviewLayer.frame = videoPreview.bounds
        
        self.videoPreview.layer.addSublayer(captureVideoPreviewLayer)
        captureSession.startRunning()
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "openQR" {
            let dest = segue.destination as! ViewController
            
        }
    }

}
