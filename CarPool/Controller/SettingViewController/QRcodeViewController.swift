//
//  QRcodeViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/12.
//

import UIKit
import AVFoundation

typealias QRCodeScanResultHandler = (Bool,[String]) -> Void

class QRcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var previewAreaView: UIView!
    @IBOutlet weak var scanLabel: UILabel!
    @IBOutlet weak var scanSwitch: UISwitch!
    var session:AVCaptureSession?
    var previewLayer:AVCaptureVideoPreviewLayer?
    var stillImageOutput:AVCaptureStillImageOutput?
    var captureMetadataOutput = AVCaptureMetadataOutput()
    let loginMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
    var scanMemberNo = 0
    var scanRectView:UIView!
    
    let allTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.code128, AVMetadataObject.ObjectType.code39, AVMetadataObject.ObjectType.code93, AVMetadataObject.ObjectType.upce, AVMetadataObject.ObjectType.pdf417, AVMetadataObject.ObjectType.ean13, AVMetadataObject.ObjectType.aztec]
    
    var resultHandler:QRCodeScanResultHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanSwitch.isOn = true
        startToScan()
        view.bringSubview(toFront: scanLabel)
        view.bringSubview(toFront: scanSwitch)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopScanning()
    }
    
    @IBAction func scanEnableSwitchValueChanged(_ sender: AnyObject) {
        let switchView = sender as! UISwitch
        if switchView.isOn {
            startToScan()
        } else {
            stopScanning()
            dismiss(animated: true, completion: nil)
        }
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
        settingCatchFrame()
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
        
        if metadataObjects.count == 0 {
            print("No QR code is detected")
            return
        }
        
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        
        // Check if it is capturing still image.
        guard stillImageOutput?.isCapturingStillImage == false else {
            return
        }
        
        if let value = metadataObj.stringValue {
            print("Receive String: \(value)")
            
            guard let memberNo = Int(value) else {
                assertionFailure()
                return
            }
            scanMemberNo = memberNo
            print("Receive String: \(scanMemberNo)")
            
            handleScanInfo(memberNo: scanMemberNo)
            
            // Stop scanning
            self.stopScanning()
        }
    }
    
    
    // HandleScanInfo
    func handleScanInfo(memberNo:Int) {

        Communicator.shared.getMemberInfo(memberNo: memberNo) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                let lastName = content["lastName"] as! String
                let firstName = content["firstName"] as! String
                let phone = content["phone"] as! String
                
                let scanMemberName = lastName + firstName
                let scanMemberPhone = phone
                self.showResultAlert(memberName: scanMemberName, memberPhone: scanMemberPhone)
            } else {
                self.showAlert(message: "查無此會員\n請確認後重新掃描")
                self.startToScan()
            }
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    
    // Show Alert
    func showResultAlert(memberName: String, memberPhone: String) {
        
        let alert = UIAlertController(title: "請選擇設定功能", message: "會員名稱: \(memberName)", preferredStyle: .alert)
        let gruadSetting = UIAlertAction (title: "守護天使", style: .default ) { (action) in
            let memberInfo = [memberName, memberPhone]
            self.resultHandler?(true, memberInfo)
            self.resultHandler = nil
            self.modifyGuardInfo()
            self.dismiss(animated: true, completion: nil)
        }
        let onSetting = UIAlertAction (title: "上車確認", style: .default ) { (action) in
            //...
            self.dismiss(animated: true, completion: nil)
        }
        let offSetting = UIAlertAction (title: "下車確認", style: .default ) { (action) in
            //...
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction (title: "取消", style: .default ) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(gruadSetting)
        alert.addAction(onSetting)
        alert.addAction(offSetting)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Modify guardInfo into database
    func modifyGuardInfo() {
        print("loginMemberNo: \(self.loginMemberNo), scanMemberNo: \(self.scanMemberNo)")
       
        Communicator.shared.modifyGuardInfo(memberNo: loginMemberNo, guardMemberNo: scanMemberNo) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤:\(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let msg = response ["msg"] as! String
            print(msg)
        }
    }
    
    //Setting catch frame
    func settingCatchFrame() {
        //計算中間可探測區域
        let windowSize = UIScreen.main.bounds.size;
        let scanSize = CGSize(width:windowSize.width*3/4,
                              height:windowSize.width*3/4)
        var scanRect = CGRect(x:(windowSize.width-scanSize.width)/2,
                              y:(windowSize.height-scanSize.height)/2,
                              width:scanSize.width, height:scanSize.height)
        //計算rectOfInterest 注意x,y交換位置
        scanRect = CGRect(x:scanRect.origin.y/windowSize.height,
                          y:scanRect.origin.x/windowSize.width,
                          width:scanRect.size.height/windowSize.height,
                          height:scanRect.size.width/windowSize.width)
        //設置可探測區域
        captureMetadataOutput.rectOfInterest = scanRect
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.frame = UIScreen.main.bounds
        self.view.layer.insertSublayer(previewLayer!, at:0)
        
        //添加探測區域的框線
        self.scanRectView = UIView();
        self.view.addSubview(self.scanRectView)
        self.scanRectView.frame = CGRect(x:0, y:0, width:scanSize.width,
                                         height:scanSize.height)
        self.scanRectView.center = CGPoint(x:UIScreen.main.bounds.midX,
                                           y:UIScreen.main.bounds.midY)
        self.scanRectView.layer.borderColor = UIColor(red: 50, green: 167, blue: 199, alpha: 1).cgColor
        self.scanRectView.layer.borderWidth = 2
    }
}


