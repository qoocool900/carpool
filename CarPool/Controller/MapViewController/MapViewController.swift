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

    deinit{
        print("deinit")
    }
    @IBOutlet weak var getInButton: RoundButton!
    @IBOutlet weak var sosButton: RoundButton!
    @IBOutlet weak var mainMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var tipId=""
    
    let passengerDicArray = [["tripID":"P00001","memberNo":"1","destination":"中壢車站","people":"1","date":"1","onMap":"1","boarding":"中央大學", "lat":24.965639, "lon":121.191013], ["tripID":"P00002","memberNo":"2","destination":"桃園高鐵站","people":"2","date":"1","onMap":"1","boarding":"中央大學7-11", "lat":24.968854, "lon":121.191756], ["tripID":"P00003","memberNo":"3","destination":"板橋車站","people":"3","date":"1","onMap":"1","boarding":"中央大學後門全家", "lat":24.964608, "lon":121.190866]] as [[String : Any]]
    
    let driverDicArray = [["tripID":"D00001","memberNo":"10","carNo":"123-qwe","people":1,"date":"1","destination":"亞東醫院","departure":"XXX","fee":"100", "lat":24.968292, "lon":121.196959, "evaluation":4.4], ["tripID":"D00002","memberNo":"11","carNo":"456-fgh","people":1,"date":"1","destination":"中壢車站","departure":"XXX","fee":"50", "lat":24.965322, "lon":121.191069, "evaluation":4.7], ["tripID":"D00003","memberNo":"12","carNo":"678-cvr","people":1,"date":"1","destination":"新竹大遠百","departure":"XXX","fee":"200", "lat":24.967770, "lon":121.191162, "evaluation":3.4]] as [[String:Any]]
    
    var passengerPins = [PassengerPin]()
    var carAnnotations = [CustomAnnotation]()
    var peopleAnnotations = [CustomAnnotation]()
    var role:Int = 0 {
        didSet {
            if role == 1 {
                addPeopleAnnatation()
                mainMapView.removeAnnotations(carAnnotations)
            } else if role == 0 {
                addCarAnnotation()
                mainMapView.removeAnnotations(peopleAnnotations)
            } else {
                mainMapView.removeAnnotations(carAnnotations)
                mainMapView.removeAnnotations(peopleAnnotations)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getInButton.setRadiusWithShadow()
        sosButton.setRadiusWithShadow()
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
    
    @IBAction func roleChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            role = 0
        case 1:
            role = 1
        case 2:
            role = 2
        default:
            break
        }
    }
    
    func addPeopleAnnatation() {
        Communicator.shared.getTrips(status: 0, onMap: 1) { (error, result) in
            if let error = error{
                print(error)
                return
            }
            let content = result!["content"] as! [[String : Any]]
            print(content)
            for dic in content {
                let tripId = dic["trip_ip"] as! String
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
        Communicator.shared.getDriverTrips(status: 0) { (error, result) in
            if let error = error {
                print(error)
                return
            }
            let content = result!["content"] as! [[String : Any]]
            print(content)
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
        //guard let 用法 如果條件不合 就放行 與if是相反的
        NSLog("Current Location: \(coordinate.latitude),\(coordinate.longitude)")
    }

}


// MARK: - MKMapViewDelegate Methods.
extension MapViewController: MKMapViewDelegate, inviteRidingCallOutViewDelegate {
    
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
        tipId = customAnnotation.tripId!
        print(tipId)
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
        showAlert(message: "邀請成功")
        print(tipId)
//        Communicator.shared.addRequest(driverTripID: tipId, passengerTripID: "P180308002", reqType: role) { (error, result) in
//            if let error = error {
//
//            }
//            print(result!)
//        }
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
