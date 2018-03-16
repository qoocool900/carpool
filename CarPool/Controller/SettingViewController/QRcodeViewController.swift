//
//  QRcodeViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/12.
//

import UIKit
import AVFoundation

class QRcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var previewAreaView: UIView!
    
    var session:AVCaptureSession?
    var previewLayer:AVCaptureVideoPreviewLayer?
    var stillImageOutput:AVCaptureStillImageOutput?
    var scanMemberName = ""
    var scanMemberPhone = ""
    
    let allTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.aztec]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startToScan()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopScanning()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Scan Session Methods
    func startToScan() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        var inputDevice:AVCaptureDeviceInput?
        do {
            // Prepare input and session
            inputDevice = try AVCaptureDeviceInput(device: captureDevice!)
        } catch {
            print("Error when prepare input: \(error)")
            return
        }
        
        session = AVCaptureSession()
        session?.addInput(inputDevice!)
        
        // Prepare output object
        let captureMetadataOutput = AVCaptureMetadataOutput()
        session?.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = allTypes
        
        // Prepare Still Image
        stillImageOutput = AVCaptureStillImageOutput()
        session!.addOutput(stillImageOutput!)
        
        // Prepare Preview Layer
        previewLayer = AVCaptureVideoPreviewLayer(session: session!)
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer!)
        
        // Start Capture
        session?.startRunning()
    }
    
    func stopScanning() {
        
        // Stop Capture
        session?.stopRunning()
        session = nil
        previewLayer?.removeFromSuperlayer()
        previewLayer = nil
        stillImageOutput = nil
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Method
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            print("No QR code is detected")
            return
        }
        
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        
        // Check if it is capturing still image.
        guard stillImageOutput?.isCapturingStillImage == false else {
            return
        }
        
        if metadataObj.stringValue != nil {
            print("Receive String: \(metadataObj.stringValue!)")
            print("Receive String: \(Int(metadataObj.stringValue!)!)")
            
            Communicator.shared.getMemberInfo(memberNo: Int(metadataObj.stringValue!)!) { (error, result) in
                if let error = error {
                    NSLog("Check member information fail: \(error)")
                    return
                }
                // success
                print(result!)
                guard let lastName = result!["lastName"] as? String else {
                    return
                }
                guard let firstName = result!["firstName"] as? String else {
                    return
                }
                guard let phone = result!["phone"] as? String else {
                    return
                }
                self.scanMemberName = lastName + firstName
                self.scanMemberPhone = phone
                
                // Show Result
                let alert = UIAlertController(title: "請選擇設定功能", message: self.scanMemberName, preferredStyle: .alert)
               
                let gruadSetting = UIAlertAction (title: "守護天使", style: .default ) { (action) in
                    if let guardVC = self.storyboard?.instantiateViewController(withIdentifier: "GuardViewController") as? GuardViewController {
                        guardVC.scanMemberName = self.scanMemberName
                        guardVC.scanMemberPhone = self.scanMemberPhone
//                        self.show(guardVC, sender: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                let onSetting = UIAlertAction (title: "上車確認", style: .default ) { (action) in
                    
                    self.dismiss(animated: true, completion: nil)
                }
                let offSetting = UIAlertAction (title: "下車確認", style: .default ) { (action) in
                    
                    self.dismiss(animated: true, completion: nil)
                }
                    
                alert.addAction(gruadSetting)
                alert.addAction(onSetting)
                alert.addAction(offSetting)
                self.present(alert, animated: true, completion: nil)
                
                // Stop scanning
                self.stopScanning()
            }
        }
    }
    
//    func show(_ vc: UIViewController, sender: Any?) {
//        let storyboard = UIStoryboard(name: "Guard", bundle: nil)
//        let controller = storyboard.instantiateInitialViewController()
//        self.view.window?.rootViewController = controller
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "GuardViewController"{
//            print("scanMemberName:\(scanMemberName)")
//            print("scanMemberPhone:\(scanMemberPhone)")
//            let guardVC = segue.destination as? GuardViewController
//            guardVC?.scanMemberName = scanMemberName
//            guardVC?.scanMemberPhone = scanMemberPhone
//        }
//    }
    
//
}
