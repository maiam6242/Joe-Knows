//
//  Beacon Set.swift
//  Joe Knows
//
//  Created by Maia Materman on 4/10/19.
//  Copyright © 2019 Annie Tor. All rights reserved.
//

import Foundation
import CoreLocation

struct BeaconSet{
    var ID:String = ""
    var uuid:UUID = UUID(uuidString: "NO UUID HERE")!
    static var beacon = Dictionary<String,beaconData>()
    
    
    static func beaconSet(ID : String) -> Dictionary<String,beaconData>{
        
        
        
        func fillMap(){
            beacon["UUID1"] = beaconData(n:"TestName", c:1, f:3)
            beacon["UUID2"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID3"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID4"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID5"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID6"] = beaconData(n: "TestName", c: 1, f: 3)
            beacon["UUID7"] = beaconData(n: "TestName", c: 1, f: 3)
            
        }
        fillMap()
        return beacon
    }
    
    
//    let majorValue: CLBeaconMajorValue
//    let minorValut: CLBeaconMinorValue
//    init(name:String, icon: Int, uuid: UUID, majorValue: Int, minorValue: Int){
//
    
  //  }
    
}