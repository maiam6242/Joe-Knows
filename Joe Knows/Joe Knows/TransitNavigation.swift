//
//  TransitNavigation.swift
//  Joe Knows
//
//  Created by Annie Tor on 4/6/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreBluetooth

class TransitNavigation: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, CBPeripheralDelegate {

    var mapV: MKMapView!
    var locationManager : CLLocationManager!
    @IBOutlet weak var whereToLabel: UILabel!
    @IBOutlet weak var Directions: UILabel!
    var buttonIndex = 10
    
    var labels : [UILabel?] = []
    
    func fillLabelsArray(){
        labels.append(Dir1)
        
    }
    @IBOutlet weak var Dir1: UILabel!
    @IBOutlet weak var Dir2: UILabel!
    @IBOutlet weak var Dir3: UILabel!
    @IBOutlet weak var Dir4: UILabel!
    @IBOutlet weak var Dir5: UILabel!
    @IBOutlet weak var Dir6: UILabel!
    @IBOutlet weak var Dir7: UILabel!
    @IBOutlet weak var Dir8: UILabel!
    @IBOutlet weak var Dir9: UILabel!
    @IBOutlet weak var Dir10: UILabel!
    @IBOutlet weak var Dir11: UILabel!
    @IBOutlet weak var Dir12: UILabel!
    @IBOutlet weak var Dir13: UILabel!
    @IBOutlet weak var Dir14: UILabel!
    @IBOutlet weak var Dir15: UILabel!
    @IBOutlet weak var Dir16: UILabel!
    @IBOutlet weak var Dir17: UILabel!
    @IBOutlet weak var Dir18: UILabel!
    @IBOutlet weak var Dir19: UILabel!
    @IBOutlet weak var Dir20: UILabel!
    
    //var centralManager:CBCentralManager!
    var RSSIs = [NSNumber]()
    var data = NSMutableData()
    var writeData: String = ""
    var peripherals: [CBPeripheral] = []
    var characteristicValue = [CBUUID: NSData]()
    var timer = Timer()
    var characteristics = [String : CBCharacteristic]()
    var blePeripheral : CBPeripheral?
    var navTo : CBPeripheral?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerWrapped.setDelegate(currentClass: self)
        
    }
    
    @IBAction func TransitDirectionsBack(_ sender: Any) {
        performSegue(withIdentifier: "DirectionsToNav", sender: self)
    }
    
    @IBAction func DirectionsExt(_ sender: Any) {
        performSegue(withIdentifier: "DirectionsExtNext", sender: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createMapView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManagerWrapped.determineCurrentLocation()
        readButton()
        findDirection()
        startScan()
        
    }
    func moveScreens(){
        print("is this going to move?!")
        let BeNav = storyboard!.instantiateViewController(withIdentifier: "BeaconNavigation") as! BeaconNavigation
        self.present(BeNav, animated: true, completion: nil)
        
    }
    
    var latDest:Double? = 0
    var lonDest:Double? = 0
    
    func readButton(){
        print("are we here")
        let distance = BeaconSet.distanceOrder[buttonIndex].value
        let UUID = BeaconSet.distanceOrder[buttonIndex].name
        print(distance)
        print(UUID)
        
        latDest = BeaconSet.beacon[UUID]?.getCoordLat()
        lonDest = BeaconSet.beacon[UUID]?.getCoordLon()
        
        print(latDest!)
        print(lonDest!)
       
        
    }
    
    func findDirection(){
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        let dest = MKPlacemark.init(coordinate: CLLocationCoordinate2D.init(latitude: latDest!, longitude: lonDest!))
        request.destination = MKMapItem.init(placemark: dest)
        request.requestsAlternateRoutes = true
        request.transportType = MKDirectionsTransportType.walking
        
        print(request)
        let directions = MKDirections(request: request)
        print(directions)
        print(directions.debugDescription)
        print(directions.description)
       
        directions.calculate { (directions, error) in
            
            if let response = directions, let route = response.routes.first {
                print(route.distance)
                let steps = route.steps
                print(route.expectedTravelTime/60)
                //in minutes
                print("hey am I here?!")
                
                
                 let address = self.getAddress(userLocation: request.destination!)
                
                print((route.expectedTravelTime/60).rounded())
                print(address)
                
                self.whereToLabel.text = "\(address) The estimated time to get there is: \(Int((route.expectedTravelTime/60).rounded())) minutes"
                
                var n = 0
                n = steps.count
                var i = 1
                if i < n{
                    self.Dir1.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir2.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir3.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir4.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir5.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir6.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir7.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir8.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir9.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir10.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir11.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir12.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir13.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir14.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir15.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir16.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir17.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir18.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir19.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }
                i += 1
                if i < n{
                    self.Dir20.text = steps[i].instructions + " in \(Int((steps[i].distance*3.281).rounded())) feet"
                }

            }
        }
    }
    
    func showRoute(_ response: MKDirections.Response){
        for route in response.routes {
            for step in route.steps{
                print(step.instructions)
            }
        }
    }
    
    func createMapView(){
        let mapObject = map.init(actualScreenView: view)
        mapV = mapObject.mapView
    }
    
    var userLocation: CLLocation = CLLocation.init()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapV.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        
        myAnnotation.title = "Current location"
        mapV.addAnnotation(myAnnotation)
    }
    
    func getAddress(userLocation:MKMapItem) -> String{
        var address = ""
        let uLocationLat = userLocation.placemark.coordinate.latitude
        let uLocationLon = userLocation.placemark.coordinate.longitude
        let userLocation = CLLocation.init(latitude:uLocationLat, longitude: uLocationLon)
        
        let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(userLocation) {(placemarks, error) in
                 address = self.processResponse(withPlacemarks: placemarks, error: error, userLocation: userLocation)
                
            }
        return address
        }
    
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?, userLocation:CLLocation) -> String{
    
        if let placemarks = placemarks, let placemark = placemarks.first {
            return placemark.compactAddress!
        }
        else{
            return "No matching Addresses Found"
        }
    }
  
}

extension TransitNavigation: CBCentralManagerDelegate{
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        blePeripheral = peripheral
        
        self.peripherals.append(peripheral)
        self.RSSIs.append(RSSI)
        peripheral.delegate = self
        print("cool cool")
        print(peripheral.name as Any)
        
        if (((peripheral.name?.localizedCaseInsensitiveContains("Adafruit")) ?? false)){
            print(peripheral.name as Any)
            centralManager1.connect(peripheral, options: nil)
            navTo = peripheral
            beaconLoc = peripheral
            cancelScan()
            moveScreens()
        }
        
        if blePeripheral == nil {
            print("Found new pheripheral devices with services")
            print("Peripheral name: \(String(describing: peripheral.name))")
            print("**********************************")
            print ("Advertisement Data : \(advertisementData)")
        }
    }
    func startScan() {
        print("Now Scanning...")
        self.timer.invalidate()
        centralManager1?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:false])
        print("what if thiS worked?!")
        print(centralManager1.isScanning)
        print(centralManager1.state)
        
        Timer.scheduledTimer(timeInterval: 1700, target: self, selector: #selector(self.cancelScan), userInfo: nil, repeats: false)}
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .poweredOn:
            print("central.state is .poweredOn")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .unsupported:
            print("central.state is .unsupported")
        case .resetting:
            print("central.state is .resetting")
        case .unauthorized:
            print("central.state is .unauthorized")
        @unknown default:
            print("central.state is .default")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("What if the RSSI worked?!")
        peripheral.readRSSI()
        print(RSSI.intValue)
        print("is this what is being read?")
    }
    
    @objc func cancelScan() {
        centralManager1?.stopScan()
        print("Scan Stopped")
        print("Number of Peripherals Found: \(peripherals.count)")
    }
}
