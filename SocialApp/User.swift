//
//  Api.swift
//  SocialApp
//
//  Created by Crunch Cubes on 10/9/17.
//  Copyright © 2017 Crunch Cubes. All rights reserved.
//

import Foundation
import CoreLocation

struct User {
    var name : String
    var description : String
    var imageURL : String
    var thumbNailImageURL : String
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        guard let firstName = json["first_name"] as? String else {throw SerializationError.missing("Error")}
        guard let lastName = json["last_name"] as? String else {throw SerializationError.missing("Error")}
        guard let description = json["email"] as? String else {throw SerializationError.missing("Error")}
        guard let imageURL = json["image_url"] as? String else {throw SerializationError.missing("Error")}
        guard let thumbNailImageURL = json["image_thumbnail_url"] as? String else {throw SerializationError.missing("Error")}


        
       
        
        self.name = firstName + " " + lastName
        self.description = description
        self.imageURL = imageURL
        self.thumbNailImageURL = thumbNailImageURL
    }
    
    
    static let basePath = "https://my.api.mockaroo.com/profiles.json?key=2ead0c10"
    
    static func forecast (withLocation location:String, completion: @escaping ([User]?) -> ()) {
        
        let url = "https://my.api.mockaroo.com/profiles.json?key=2ead0c10"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[User] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] {
                        for dataPoint in json {
                            if let weatherObject = try? User(json: dataPoint) {
                                forecastArray.append(weatherObject)
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
                
            }
            
            
        }
        
        task.resume()
        
        
        
        
        
        
        
        
        
    }
    
    
}
