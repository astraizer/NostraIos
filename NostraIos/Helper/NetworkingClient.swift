//
//  NetworkingClient.swift
//  NostraIos
//
//  Created by Nostra on 8/17/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient{
    
    typealias WebServiceResponse = ([[String:Any]]?,Error?)->Void
    
    func execute(_ url: URL,category:String,country: String,apiKey:String, completion:@escaping WebServiceResponse){
        var parameters:Parameters
        if country != ""{
            parameters=[
                "country":country,
                "ApiKey":apiKey,    
                "category":category
            ]
        }
        else {
            parameters=[
                "ApiKey":apiKey,
                "category":category
            ]
        }
        
        Alamofire.request(url, method: .get, parameters: parameters ).validate().responseJSON { response in
            if let error = response.error{
                completion(nil,error)
            }
            else if let jsonArray = response.result.value as? [[String:Any]]{
                completion(jsonArray,nil)
            }
            else if let jsonDict = response.result.value as? [String:Any]{
                completion([jsonDict],nil)
            }
        }
        
    }
}
