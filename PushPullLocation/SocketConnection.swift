//
//  SocketConnection.swift
//  PushPullLocation
//
//  Created by Eugene Mu on 1/19/16.
//  Copyright © 2016 Eugene Mu. All rights reserved.
//

import UIKit
import MapKit
//import SwiftyJSON

class Connection {
    var annotations = [MKAnnotation]()
    
    class var sharedInstance: Connection {
        struct Static {
            static let instance: Connection = Connection()
        }
        return Static.instance
    }
    
    var socket: SocketIOClient?
    
    func connectToServer() {
        socket = SocketIOClient(socketURL: "http://localhost:5000")
        socket?.connect()
        socket?.on("connect") { data, ack in
            print("Connected to Server")
        }
    }
    
    func sendToServer(name: String) {
        socket?.emit("userEntered", name)
    }
    
    func sendToServer(location: AnyObject) {
        socket?.emit("locationEntered", location)
    }
    
    func retrieveFromServer() {
        socket?.emit("pullLocation")
    }
    
    func receiveFromServer() {
        
        
        socket?.on("giveLocations") { data, ack in
            
            self.annotations.removeAll()
            
            let json = JSON(data)
            
            for var i = 0; i < json[0].count; i++ {
                let lat = json[0][i]["location"][0].double
                let lon = json[0][i]["location"][1].double
                let name = json[0][i]["name"].string
                let location = CLLocationCoordinate2DMake(lat!, lon!)
                
                let annotation = MKPointAnnotation()
                annotation.title = name
                annotation.coordinate = location
                
                self.annotations.append(annotation)

            }
        }
    }
    
    
}



