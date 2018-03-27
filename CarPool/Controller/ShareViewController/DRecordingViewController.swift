//
//  DRecordgingViewController.swift
//  CarPool
//
//  Created by 胡靜諭 on 2018/3/26.
//
import UIKit
class DRecordgingViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var DRecordingTableView: UITableView!
    
    var driverRecord = [DriverTrip]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return driverRecord.count
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //    }
    //
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  DRecordingTableView.dequeueReusableCell(withIdentifier:"driverSetCell" , for: indexPath) as? DRecordingTableViewCell else{
            
            return UITableViewCell()
        }
        
        cell.driverBoarding.text = driverRecord[indexPath.row].departure
        cell.driverDestination.text = driverRecord[indexPath.row].destination
        cell.driverFee.text = "\(String(driverRecord[indexPath.row].fee))元"
        cell.driverCapacity.text = "\(String(driverRecord[indexPath.row].people))人"
        cell.driverSetdate.text = driverRecord[indexPath.row].date
        cell.driverCarNo.text = driverRecord[indexPath.row].carNo
        
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DRecordingTableView.delegate = self
        DRecordingTableView.dataSource = self
        
        let defaults = UserDefaults.standard
        let driverNo = defaults.integer(forKey: "memberNo")
        print (driverNo)
        
        Communicator.shared.getMyTrips(memberNo:driverNo , role: 1) { (error, result) in
            if let error = error {
                NSLog("getDriverSetRecord fail: \(error)")
                self.showAlert(message: "伺服器連線失敗")
                return
            }
            //success
            guard let content = result!["content"]as?[[String:Any]]
                else{
                    return
            }
            print(content)
            guard let response = result!["response"]as? [String:Any] else{
                return
            }
            let code = response["code"] as?Int
            if code == 0 {
                //success
                self.driverRecord = Common.shared.getMyDriverTrips(diverTripsArray: content)
                self.DRecordingTableView.reloadData()
            }
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
