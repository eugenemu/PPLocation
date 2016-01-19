//
//  SocketConnection.swift
//  PushPullLocation
//
//  Created by Eugene Mu on 1/19/16.
//  Copyright © 2016 Eugene Mu. All rights reserved.
//

import UIKit

class Connection {
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
            print(data)
            let users = data as! NSDictionary
            
        }
    }
    
    
}



