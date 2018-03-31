//
//  DriveViewController.swift
//  CarPool
//
//  Created by Amber Yang on 2018/3/6.
//

import UIKit

class DriveViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var carNumberTextField: UITextField!
    @IBOutlet weak var carBrandTextField: UITextField!
    @IBOutlet weak var carStyleTextField: UITextField!
    @IBOutlet weak var carColorTextField: UITextField!
    @IBOutlet weak var scoreDriver1ImageView: UIImageView!
    @IBOutlet weak var scoreDriver2ImageView: UIImageView!
    @IBOutlet weak var scoreDriver3ImageView: UIImageView!
    @IBOutlet weak var scoreDriver4ImageView: UIImageView!
    @IBOutlet weak var scoreDriver5ImageView: UIImageView!
    @IBOutlet weak var scoreSafty1ImageView: UIImageView!
    @IBOutlet weak var scoreSafty2ImageView: UIImageView!
    @IBOutlet weak var scoreSafty3ImageView: UIImageView!
    @IBOutlet weak var scoreSafty4ImageView: UIImageView!
    @IBOutlet weak var scoreSafty5ImageView: UIImageView!
    @IBOutlet weak var scoreComfort1ImageView: UIImageView!
    @IBOutlet weak var scoreComfort2ImageView: UIImageView!
    @IBOutlet weak var scoreComfort3ImageView: UIImageView!
    @IBOutlet weak var scoreComfort4ImageView: UIImageView!
    @IBOutlet weak var scoreComfort5ImageView: UIImageView!
    
    let pickerView = UIPickerView()
    var carBrand = "Ferrari"
    var carType = "F430"
    let loginMemberNo = UserDefaults.standard.integer(forKey: "memberNo")
    


    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        getCarInfo(memberNo: loginMemberNo)
        getScoreInfo(memberNo: loginMemberNo)
        carBrandTextField.inputView = pickerView
        carStyleTextField.inputView = pickerView
        carColorTextField.inputView = pickerView
    }

    
    @IBAction func saveBtnPressed(_ sender: Any) {
        modifyMemberInfo(memberNo: loginMemberNo)
    }
    
    
    // MARK: - PickerView
    let carBrandList =  ["Ferrari","Marserati","Lamborghini"]
    let carStyleFerrariList = ["F430","599", "GTB Fiorano"]
    let carStyleMarseratiList = ["Ghibli","GranCabrio","Levante"]
    let carStyleLamborghiniList = ["Aventador"," Huracan","Huracan Spyder"]
    let carColorList = ["White", "Black", "Blue", "Brown", "Red", "Yellow"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return carBrandList.count
        case 1:
            switch carBrand{
            case "Ferrari":
                return carStyleFerrariList.count
            case "Marserati":
                return carStyleMarseratiList.count
            case "Lamborghini":
                return carStyleLamborghiniList.count
            default:
                return 0
            }
        case 2:
            return carColorList.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return carBrandList[row]
        case 1:
            switch carBrand{
            case "Ferrari":
                return carStyleFerrariList[row]
            case "Marserati":
                return carStyleMarseratiList[row]
            case "Lamborghini":
                return carStyleLamborghiniList[row]
            default:
                return nil
            }
        case 2:
            return carColorList[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            carBrand = carBrandList[row]
            carBrandTextField.text = carBrand
            updateCarStyle(0)
            pickerView.reloadAllComponents()
            carStyleTextField.text = ""
            pickerView.selectRow(0, inComponent: 1, animated: true)
        case 1:
            updateCarStyle(row)
            carStyleTextField.text = carType
            carBrandTextField.text = carBrand
            pickerView.reloadAllComponents()
        case 2:
            carColorTextField.text = carColorList[row]
        default:
            break
        }
    }
    
    func updateCarStyle(_ row: Int){
        switch carBrand {
        case "Ferrari":
            carType = carStyleFerrariList[row]
        case "Marserati":
            carType = carStyleMarseratiList[row]
        case "Lamborghini":
            carType = carStyleLamborghiniList[row]
        default:
            break
        }
    }
    
    //MARK: -Keybord Setting
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: -Link to DataBase
    // Get CarInfo From DataBase
    func getCarInfo(memberNo: Int){
        var msg: String = ""
        Communicator.shared.getCarInfo(memberNo: memberNo) { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let content = result!["content"] as! [String:Any]
            let code = response ["code"] as! Int
            if  code == 0 {
                let carNo = content["carNo"] as! String
                let brand = content["brand"] as! String
                let type = content["type"] as! String
                let color = content["color"] as! String
                
                self.carNumberTextField.text = carNo
                self.carBrandTextField.text = brand
                self.carStyleTextField.text = type
                self.carColorTextField.text = color
                
                let defaults = UserDefaults.standard
                defaults.set(carNo, forKey: "carNo")
                defaults.synchronize()

            } 
            msg = response["msg"] as! String
            print(msg)
        }
    }
    
    // Get scoreInfo From DataBase
    func getScoreInfo(memberNo: Int){
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
                let scoreDriver = content["scoreDriver"] as! Double
                let scoreSafty = content["scoreSave"] as! Double
                let scoreComfort = content["scoreComfort"] as! Double
                
                //Setting scoreDriver image
                self.scoreDriver1ImageView.image = self.checkStarImage(scoreDriver)[0]
                self.scoreDriver2ImageView.image = self.checkStarImage(scoreDriver)[1]
                self.scoreDriver3ImageView.image = self.checkStarImage(scoreDriver)[2]
                self.scoreDriver4ImageView.image = self.checkStarImage(scoreDriver)[3]
                self.scoreDriver5ImageView.image = self.checkStarImage(scoreDriver)[4]
                
                //Setting scoreSafity image
                self.scoreSafty1ImageView.image = self.checkStarImage(scoreSafty)[0]
                self.scoreSafty2ImageView.image = self.checkStarImage(scoreSafty)[1]
                self.scoreSafty3ImageView.image = self.checkStarImage(scoreSafty)[2]
                self.scoreSafty4ImageView.image = self.checkStarImage(scoreSafty)[3]
                self.scoreSafty5ImageView.image = self.checkStarImage(scoreSafty)[4]
                
                //Setting scoreComfort image
                self.scoreComfort1ImageView.image = self.checkStarImage(scoreComfort)[0]
                self.scoreComfort2ImageView.image = self.checkStarImage(scoreComfort)[1]
                self.scoreComfort3ImageView.image = self.checkStarImage(scoreComfort)[2]
                self.scoreComfort4ImageView.image = self.checkStarImage(scoreComfort)[3]
                self.scoreComfort5ImageView.image = self.checkStarImage(scoreComfort)[4]
            }
            let msg = response["msg"] as! String
            print(msg)
        }
    }
    
    // Modify carInfo to DataBase
    func modifyMemberInfo(memberNo: Int){
        let car = Car(carNo:carNumberTextField.text!, type:carStyleTextField.text!, color:carColorTextField.text!, brand:carBrandTextField.text!)
        
        Communicator.shared.modifyCarInfo(car, memberNo: memberNo, doneHandler: { (error, result) in
            if let error = error {
                NSLog("伺服器連線錯誤: \(error)")
                return
            }
            // success
            let response = result!["response"] as! [String:Any]
            let code = response["code"] as! Int
            if code == 0 {
                let defaults = UserDefaults.standard
                defaults.set(car.carNo, forKey: "carNo")
                defaults.synchronize()
               self.showAlert(message: "更新資料成功")
            }
            let msg = response ["msg"] as! String
            print(msg)
        })
    }
    
    //MARK: - Check Star Image
    func checkStarImage(_ score: Double) -> [UIImage]{
        var checkScore = 0.0
        
        if score >= 5.0 {
            checkScore = 5.0
        } else if score >= 4.5 {
            checkScore = 4.5
        } else if score >= 4.0 {
            checkScore = 4.0
        } else if score >= 3.5 {
            checkScore = 3.5
        } else if score >= 3.0 {
            checkScore = 3.0
        } else if score >= 2.5 {
            checkScore = 2.5
        } else if score >= 2.0 {
            checkScore = 2.0
        } else if score >= 1.5 {
            checkScore = 1.5
        } else if score >= 1.0 {
            checkScore = 1.0
        } else if score > 0.0 {
            checkScore = 0.5
        } else {
            checkScore = 0.0
        }
        
        var starImage1: UIImage!
        var starImage2: UIImage!
        var starImage3: UIImage!
        var starImage4: UIImage!
        var starImage5: UIImage!
        
        switch checkScore {
        case 0.5:
            starImage1 = UIImage(named: "star_half")
            starImage2 = UIImage(named: "star_blank")
            starImage3 = UIImage(named: "star_blank")
            starImage4 = UIImage(named: "star_blank")
            starImage5 = UIImage(named: "star_blank")
        case 1.0:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star_blank")
            starImage3 = UIImage(named: "star_blank")
            starImage4 = UIImage(named: "star_blank")
            starImage5 = UIImage(named: "star_blank")
        case 1.5:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star_half")
            starImage3 = UIImage(named: "star_blank")
            starImage4 = UIImage(named: "star_blank")
            starImage5 = UIImage(named: "star_blank")
        case 2.0:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star")
            starImage3 = UIImage(named: "star_blank")
            starImage4 = UIImage(named: "star_blank")
            starImage5 = UIImage(named: "star_blank")
        case 2.5:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star")
            starImage3 = UIImage(named: "star_half")
            starImage4 = UIImage(named: "star_blank")
            starImage5 = UIImage(named: "star_blank")
        case 3.0:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star")
            starImage3 = UIImage(named: "star")
            starImage4 = UIImage(named: "star_blank")
            starImage5 = UIImage(named: "star_blank")
        case 3.5:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star")
            starImage3 = UIImage(named: "star")
            starImage4 = UIImage(named: "star_half")
            starImage5 = UIImage(named: "star_blank")
        case 4.0:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star")
            starImage3 = UIImage(named: "star")
            starImage4 = UIImage(named: "star")
            starImage5 = UIImage(named: "star_blank")
        case 4.5:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star")
            starImage3 = UIImage(named: "star")
            starImage4 = UIImage(named: "star")
            starImage5 = UIImage(named: "star_half")
        case 5.0:
            starImage1 = UIImage(named: "star")
            starImage2 = UIImage(named: "star")
            starImage3 = UIImage(named: "star")
            starImage4 = UIImage(named: "star")
            starImage5 = UIImage(named: "star")
        default:
            starImage1 = UIImage(named: "star_blank")
            starImage2 = UIImage(named: "star_blank")
            starImage3 = UIImage(named: "star_blank")
            starImage4 = UIImage(named: "star_blank")
            starImage5 = UIImage(named: "star_blank")
        }
        
        let imageList: [UIImage] =  [starImage1, starImage2, starImage3, starImage4, starImage5]
        print("Star ImageList: \(imageList)")
        return imageList
    }
}
