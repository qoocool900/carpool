//
//  MapViewController.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/2.
//

import UIKit
import MapKit
import CoreLocation

struct PassengerPin {
    var tripID:String
    var memberNo:Int
    var destination:String
    var people:Int
    var boarding:String
    var lat:Double
    var lon:Double
    
    init(tripID:String?, memberNo:Int?, destination:String?, people:Int?, boarding:String?, lat:Double?, lon:Double?) {
        self.tripID = tripID ?? ""
        self.memberNo = memberNo ?? 0
        self.destination = destination ?? ""
        self.people = people ?? 0
        self.boarding = boarding ?? ""
        self.lat = lat ?? 0
        self.lon = lon ?? 0
    }
}

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var getInButton: RoundButton!
    @IBOutlet weak var sosButton: RoundButton!
    @IBOutlet weak var mainMapView: MKMapView!
    @IBOutlet weak var clearTrackButton: UIButton!
    
//        for annotation in carAnnotations {
//            if annotation.tripId == "D18033151" {
//                let lat = annotation.coordinate.latitude + 0.001
//                let lon = annotation.coordinate.longitude + 0.001
//                //let score = dic["evaluation"] as! Double
//                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//                annotation.coordinate = coordinate
//            }
//        }
    
    var timer:Timer?
    var timerGuard:Timer?
    var point:CLLocationCoordinate2D?
    var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    var saveLocations: [Double] = [Double]()
    var savePoints: [[Double]] = [[Double]]()
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var myTripId:String?
    var invitedTripId:String?
    var memberNo: Int?
    var guardMemberNo: Int?
    var driverMemberNo: Int?
    let defaults = UserDefaults.standard
    var passengerID:String?
    var driverID:String?
//    var getReqNo: Int?
//    var getTripId:String?
    var isfirstLoad:Bool?
    var noDataTimes = 0
    var position = ""
    
    var passengerPins = [PassengerPin]()
    var carAnnotations = [CustomAnnotation]()
    var peopleAnnotations = [CustomAnnotation]()
    var role:Int = 0 {
        didSet {
            if role == 1 {
                addPeopleAnnatation()
                mainMapView.removeAnnotations(peopleAnnotations)
                mainMapView.removeAnnotations(carAnnotations)
            } else if role == 0 {
                addCarAnnotation()
                mainMapView.removeAnnotations(carAnnotations)
                mainMapView.removeAnnotations(peopleAnnotations)
            } else {
                mainMapView.removeAnnotations(carAnnotations)
                mainMapView.removeAnnotations(peopleAnnotations)
            }
        }
    }
    var carRideMode:Int = 0 {
        didSet {
            if carRideMode == 0 {
                getInButton.setTitle("上車", for: .normal)
                sosButton.isHidden = true
            } else {
                getInButton.setTitle("下車", for: .normal)
                sosButton.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let image = UIImage(named: "tab_map")?.withRenderingMode(.alwaysOriginal)
        getInButton.isHidden = true
        clearTrackButton.isHidden = true
        mainMapView.delegate = self
        memberNo = defaults.integer(forKey: "memberNo")
        print("地圖彥面：\(memberNo!)")
        
        // init UI
        getInButton.setRadiusWithShadow()
        sosButton.setRadiusWithShadow()
        sosButton.isHidden = true
        
        // Do any additional setup after loading the view.
        addCarAnnotation()
        
        // Ask user's permission
        locationManager.requestAlwaysAuthorization()
        
        // Prepare locationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //選擇精確度
        locationManager.activityType = .automotiveNavigation //選擇活動種類 .的前面是 CLActivityType
        
        locationManager.startUpdatingLocation()
        // startMonitoringSignificantLocationChanges()不耗電的取用user位置的方法(採電信公司基地台偵測)
        
        mainMapView.delegate = self
        
        // For background mode.
        locationManager.allowsBackgroundLocationUpdates = true
        // 預設false 雖然會自動關閉 但自動開啟來時 是不準確的 會延遲
        locationManager.pausesLocationUpdatesAutomatically = false
        
//        geocoder.geocodeAddressString("中央大學") { (placemarks, error) in
//            if error != nil {
//                print("Geocode failed: \(error!.localizedDescription)")
//            } else if placemarks!.count > 0 {
//                let placemark = placemarks![0]
//                let location = placemark.location
//                print("新竹車站經緯度")
//                print(location?.coordinate.latitude ?? 0)
//                print(location?.coordinate.longitude ?? 0)
//            }
//        }
        NotificationCenter.default.addObserver(self, selector: #selector(isDataGet(notification:)), name: NSNotification.Name(rawValue:"MatchSuccess") , object: nil)
    }
    
    @objc
    func isDataGet(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let reqNo = userInfo["reqNo"] as? Int else {
            return
        }
        
        Communicator.shared.getMatchTripId(reqNo: reqNo) { (error, result) in
            if let error = error {
                print(error)
            }
            let content = result!["content"] as! [String:Any]
            self.passengerID = content["trip_passenger_id"] as? String
            self.driverID = content["trip_driver_id"] as? String
            
            
            Communicator.shared.getDriverTrips(status: 0) { (error, result) in
                if let error = error {
                    print(error)
                }
                guard let content = result!["content"] as? [[String:Any]] else {
                    return
                }
                var driverTirps = [DriverTrip]()
                driverTirps = Common.shared.getMyDriverTrips(diverTripsArray: content)
                for driverTrip in driverTirps {
                    if driverTrip.tripId == self.driverID {
                        self.driverMemberNo = driverTrip.memberNo
                        self.getInButton.isHidden = false
                    }
                }
            }
        }
        print("isdataget!")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let coordinate = locationManager.location?.coordinate else {
            NSLog("No current location.")
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mainMapView.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        print("deinit")
    }
    
    @IBAction func roleChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            role = 0
            self.mainMapView.removeOverlays(mainMapView.overlays)
            timerGuard?.invalidate()
            if getInButton.isHidden == true {
                drawMyLine()
            }
        case 1:
            role = 1
            self.mainMapView.removeOverlays(mainMapView.overlays)
            timerGuard?.invalidate()
            if getInButton.isHidden == true {
                drawMyLine()
            }
        case 2:
            role = 2
            clearPolyLine()
            isfirstLoad = true
            noDataTimes = 0
        default:
            break
        }
    }
    
    func addPeopleAnnatation() {
        mainMapView.removeAnnotations(peopleAnnotations)
        peopleAnnotations.removeAll()
        Communicator.shared.getTrips(status: 0, onMap: 1) { (error, result) in
            if let error = error{
                print(error)
                return
            }
            let content = result!["content"] as! [[String : Any]]
            //print(content)
            for dic in content {
                let tripId = dic["trip_ip"] as! String
                print("測試：\(tripId)")
                let destination = dic["destination"] as! String
                let people = dic["people"] as! Int
                let lat = dic["lat"] as! Double
                let lon = dic["lon"] as! Double
                let boarding = dic["boarding"] as! String
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let peopleAnnotation = CustomAnnotation(role: 1, tripId: tripId, destination: destination, startPosition: boarding, people: people, fee: 0, phone: "0800", score: 0, coordinate: coordinate)
                self.peopleAnnotations.append(peopleAnnotation)
            }
            self.mainMapView.addAnnotations(self.peopleAnnotations)
        }
        
    }
    
    func addCarAnnotation() {
        mainMapView.removeAnnotations(carAnnotations)
        carAnnotations.removeAll()
        Communicator.shared.getDriverTrips(status: 0) { (error, result) in
            if let error = error {
                print(error)
                return
            }
            let content = result!["content"] as! [[String : Any]]
            //print(content)
            for dic in content {
                let tripId = dic["trip_ip"] as! String
                //let memberNo = dic["memberNO"] as! Int
                let destination = dic["destination"] as! String
                let departure = dic["boarding"] as! String
                let people = dic["people"] as! Int
                let fee = dic["fee"] as! Int
                let lat = dic["lat"] as! Double
                let lon = dic["lon"] as! Double
                //let score = dic["evaluation"] as! Double
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let carAnnotation = CustomAnnotation(role: 0, tripId: tripId, destination: destination, startPosition: departure, people: people, fee: fee, phone: "0800", score: 0, coordinate: coordinate)
                self.carAnnotations.append(carAnnotation)
            }
            self.mainMapView.addAnnotations(self.carAnnotations)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {
            return
        }
        point = coordinate
        
        if driverID != nil {
            
        }
        //guard let 用法 如果條件不合 就放行 與if是相反的
        //NSLog("Current Location: \(coordinate.latitude),\(coordinate.longitude)")
//        var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
//
//        for annotation in self.carAnnotations {
//            points.append(annotation.coordinate)
//        }
//
//
//        let polyline = MKPolyline(coordinates: &points, count: points.count)
//
//        self.mainMapView.add(polyline)
    }

    @IBAction func getInButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goScanning", sender: nil)
        //getInCar(driverMemberNo: 1)
    }
    
    func getInCar(driverMemberNo:Int) {
        print(self.driverMemberNo)
        print(driverMemberNo)
        guard self.driverMemberNo == driverMemberNo else {
            showAlert(message: "😅 您上錯車囉 😅")
            return
        }
        
        if carRideMode == 0 {
            Communicator.shared.updateRecord(driverTripId: driverID!, passengerTripId: passengerID!, status: 0) { (error, result) in
                if let error = error {
                    print(error)
                }
            }
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(drawLine), userInfo: nil, repeats: true)
            carRideMode = 1
        } else {
            Communicator.shared.updateRecord(driverTripId: driverID!, passengerTripId: passengerID!, status: 1) { (error, result) in
                if let error = error {
                    print(error)
                }
            }
            timer?.invalidate()
            carRideMode = 0
            //            self.mainMapView.removeOverlays(mainMapView.overlays)
            clearTrackButton.isHidden = false
            saveLocations.removeAll()
            //savePoints.removeAll()
            getInButton.isHidden = true
        }
    }
    
    @objc
    func drawLine() {
        guard let drawPoint = point else {
            return
        }
//        for annotation in carAnnotations {
//            if annotation.tripId == driverID {
//                annotation.coordinate = drawPoint
//            }
//        }
        print("Location: \(drawPoint.latitude),\(drawPoint.longitude)")
        points.append(drawPoint)
        saveLocations.append(drawPoint.latitude)
        saveLocations.append(drawPoint.longitude)
        savePoints.append(saveLocations)
        uploadLocation()
        print(savePoints)
       
        //print("新增 \(points.count)")
        drawMyLine()
    }
    
    func drawMyLine() {
        if role < 2 {
            if points.count > 1 {
                self.mainMapView.removeOverlays(mainMapView.overlays)
                let polyline = MKPolyline(coordinates: &points, count: points.count)
                self.mainMapView.add(polyline)
                //points.remove(at: 0)
                //points.removeSubrange(0...points.count-2)
                print(points.count)
                //print("刪除 \(points.count)")
            }
        }
    }
    
    func clearPolyLine() {
        self.mainMapView.removeOverlays(mainMapView.overlays)
        timerGuard = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(drawGuardLine), userInfo: nil, repeats: true)
    }
    
    @objc
    func drawGuardLine() {
        Communicator.shared.getRoutes(memberNo: memberNo!) { (error, result) in
            if let error = error {
                print(error)
            }
            let content = result!["content"] as! [String : Any]
            guard let locationList = content["geoPosition"] else {
                //self.isfirstLoad = true
                if self.noDataTimes == 0 {
                    self.showAlert(message: "您的寶貝尚無乘車資訊")
                    
                }
                //self.timerGuard?.invalidate()
                //self.isfirstLoad = false
                self.noDataTimes = 1
                return
            }
            //self.isfirstLoad = true
            var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
            for locations in locationList as! [[Double]]{
                var point:CLLocationCoordinate2D?
                //                point?.latitude = locations[0]
                //                point?.longitude = locations[1]
                point = CLLocationCoordinate2DMake(locations[0], locations[1])
//                print(point!)
                points.append(point!)
            }
            if self.isfirstLoad! {
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let region = MKCoordinateRegion(center: points[0], span: span)
                self.mainMapView.setRegion(region, animated: true)
                self.isfirstLoad = false
                self.noDataTimes = 0
            }
            let polyline = MKPolyline(coordinates: &points, count: points.count)
            self.mainMapView.add(polyline)
        }
    }
    
    func uploadLocation() {
        Communicator.shared.addRoutes(tripId: self.passengerID!, memberNo: self.memberNo!, geoPosition: savePoints) { (error, result) in
            if let error = error {
                print(error)
            }
        }
        saveLocations.removeAll()
        savePoints.removeAll()
    }
    
    @IBAction func sosButtonPressed(_ sender: Any) {
        //memberNo = defaults.integer(forKey: "memberNo")
        callPhone(phoneNo: "110")
    }
    
    @IBAction func clearTrackButtonPressed(_ sender: Any) {
        mainMapView.removeOverlays(mainMapView.overlays)
        //saveLocations.removeAll()
        points.removeAll()
        clearTrackButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if role == 2 {
            isfirstLoad = true
            timerGuard = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(drawGuardLine), userInfo: nil, repeats: true)
        } else if role == 0 {
            addCarAnnotation()
            if getInButton.isHidden == true {
                drawMyLine()
            }
        } else if role == 1 {
            addPeopleAnnatation()
            self.noDataTimes = 0
            if getInButton.isHidden == true {
                drawMyLine()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timerGuard?.invalidate()
        mainMapView.removeOverlays(mainMapView.overlays)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? QRcodeViewController {
            vc.resultHandler = { (success:Bool, memberInfo:[String]) -> Void in
                
                NSLog("result: \(memberInfo)]")
                guard let driverMemberNo = Int(memberInfo[0]) else {
                    self.showAlert(message: "掃描失敗")
                    return
                }
                self.getInCar(driverMemberNo: driverMemberNo)
            }
        }
        
    }
}


// MARK: - MKMapViewDelegate Methods.
extension MapViewController: MKMapViewDelegate, inviteRidingCallOutViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        
        if overlay is MKPolyline {
            if role < 2 {
                polylineRenderer.strokeColor = UIColor.blue
            } else {
                polylineRenderer.strokeColor = UIColor.red
            }
            
            polylineRenderer.lineWidth = 2
            
        }
        return polylineRenderer
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.region.center
        NSLog("Region be changed to: \(center.latitude),\(center.longitude)")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let lan = (view.annotation?.coordinate.latitude)! + 0.002
        let coordinate = CLLocationCoordinate2D(latitude: lan, longitude: (view.annotation?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let customAnnotation = view.annotation as! CustomAnnotation
        invitedTripId = customAnnotation.tripId!
        mainMapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        var identifier = "Car"
        if role == 1 {
            identifier = "People"
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = CustomMKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            (annotationView as! CustomMKPinAnnotationView).inviteRidingDelegate = self
        } else {
            annotationView?.annotation = annotation
        }
        //pin?.canShowCallout = false
        return annotationView
    }
    
    func inviteRiding() {
        if role == 0 {
            Communicator.shared.getMyTrips(memberNo: memberNo!, role: 0, doneHandler: { (error, result) in
                if let error = error {
                    print(error)
                    return
                }
                let content = result!["content"] as! [[String:Any]]
                if (content.isEmpty) {
                    self.showAlert(message: "尚未發起共乘")
                    
                } else {
                    let firstPassengerTrip = Common.shared.getFirstPassengerTrip(passengerTripsArray: content)
                    self.myTripId = firstPassengerTrip.tripId
                    Communicator.shared.addRequest(driverTripID: self.invitedTripId!, passengerTripID: self.myTripId!, reqType: self.role) { (error, result) in
                        if let error = error {
                            print(error)
                        }
                        //print(result!)
                        self.showAlert(message: "邀請成功")
                    }
                    
                }
            })
        } else if role == 1 {
            Communicator.shared.getMyTrips(memberNo: memberNo!, role: 1, doneHandler: { (error, result) in
                if let error = error {
                    print(error)
                    return
                }
                let content = result!["content"] as! [[String:Any]]
                if content.isEmpty {
                    self.showAlert(message: "您尚未發起共乘，無法邀請乘客上車")
                } else {
                    let firstDriverTrip = Common.shared.getFirstDriverTrip(diverTripsArray: content)
                    self.myTripId = firstDriverTrip.tripId
                    Communicator.shared.addRequest(driverTripID: self.myTripId!, passengerTripID: self.invitedTripId!, reqType: self.role) { (error, result) in
                        if let error = error {
                            print(error)
                        }
                        //print(result!)
                        self.showAlert(message: "邀請成功")
                    }
                }
            })
        }
        
    }
}

extension UIView {
    func setRadiusWithShadow(_ radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1.2)
        self.layer.shadowRadius = 1.7
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
}
