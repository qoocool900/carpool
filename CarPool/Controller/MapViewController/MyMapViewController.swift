//
//  MyMapViewController.swift
//  CarPool
//
//  Created by 林昱丞 on 2018/3/8.
//

import UIKit
import CoreLocation
import MapKit

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

class MyMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mainMapView: MKMapView!
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    let passengerDicArray = [["tripID":"P00001","memberNo":"1","destination":"中壢車站","people":"1","date":"1","onMap":"1","boarding":"中央大學", "lat":24.965639, "lon":121.191013], ["tripID":"P00002","memberNo":"2","destination":"桃園高鐵站","people":"2","date":"1","onMap":"1","boarding":"中央大學7-11", "lat":24.968854, "lon":121.191756], ["tripID":"P00003","memberNo":"3","destination":"板橋車站","people":"3","date":"1","onMap":"1","boarding":"中央大學後門全家", "lat":24.964608, "lon":121.190866]] as [[String : Any]]
    
    let driverDicArray = [["tripID":"D00001","memberNo":"10","carNo":"123-qwe","people":"1","date":"1","destination":"亞東醫院","fee":"100", "lat":24.968292, "lon":121.196959, "evaluation":4.4], ["tripID":"D00002","memberNo":"11","carNo":"456-fgh","people":"1","date":"1","destination":"中壢車站","fee":"50", "lat":24.965322, "lon":121.191069, "evaluation":4.7], ["tripID":"D00003","memberNo":"12","carNo":"678-cvr","people":"1","date":"1","destination":"新竹大遠百","fee":"200", "lat":24.967770, "lon":121.191162, "evaluation":3.4]] as [[String:Any]]
    
    var passengerPins = [PassengerPin]()
    var carAnnotations = [CustomAnnotation]()
    var peopleAnnotations = [CustomAnnotation]()
    var role:Int = 0 {
        didSet {
            if role == 1 {
                addPeopleAnnatation()
                mainMapView.removeAnnotations(carAnnotations)
                NSLog("role:1")
            } else {
                addCarAnnotation()
                mainMapView.removeAnnotations(peopleAnnotations)
                NSLog("role:0")
            }
        }
    }
    
    @IBAction func btn(_ sender: Any) {
        addCarAnnotation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCarAnnotation()
//        Communicator.shared.getTrips(status: 123) { (error, result) in
//            if let error = error {
//                return
//            }
//            print(result!)
//        }
        // Do any additional setup after loading the view.
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
        
        geocoder.geocodeAddressString("中央大學") { (placemarks, error) in
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                print("新竹車站經緯度")
                print(location?.coordinate.latitude ?? 0)
                print(location?.coordinate.longitude ?? 0)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
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
       
        //addCarAnnotation()
        
        
    }
    
    func addPeopleAnnatation() {
        for dic in passengerDicArray {
            let destination = dic["destination"] as! String
            let people = dic["people"] as! String
            let lat = dic["lat"] as! Double
            let lon = dic["lon"] as! Double
            let fee = dic["boarding"] as! String
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let peopleAnnotation = CustomAnnotation(destination: destination, people: people, fee: fee, coordinate: coordinate)
            peopleAnnotations.append(peopleAnnotation)
        }
        mainMapView.addAnnotations(peopleAnnotations)
    }
    
    func addCarAnnotation() {
        for dic in driverDicArray {
            //let tripId = dic["tripID"] as! String
            //let memberNo = dic["memberNO"] as! Int
            let destination = dic["destination"] as! String
            //let boarding = dic["boarding"] as! String
            let people = dic["people"] as! String
            let fee = dic["fee"] as! String
            let lat = dic["lat"] as! Double
            let lon = dic["lon"] as! Double
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//            let passengerPin = PassengerPin(tripID: tripId, memberNo: memberNo, destination: destination, people: people, boarding: boarding, lat: lat, lon: lon)
//            self.passengerPins.append(passengerPin)
            let carAnnotation = CustomAnnotation(destination: destination, people: people, fee: fee, coordinate: coordinate)
            carAnnotations.append(carAnnotation)
        }
        mainMapView.addAnnotations(carAnnotations)
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
extension MyMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.region.center
        NSLog("Region be changed to: \(center.latitude),\(center.longitude)")
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(123456789)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: (view.annotation?.coordinate)!, span: span)
        mainMapView.setRegion(region, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "Marker"
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if pin == nil {
            pin = CustomMKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            pin?.annotation = annotation
        }
        //pin?.canShowCallout = false
        return pin
    }
    
    
}
