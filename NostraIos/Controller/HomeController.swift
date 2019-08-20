//
//  HomeController.swift
//  NostraIos
//
//  Created by Nostra on 19/08/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeController{
    func getData(country : String, completion : @escaping ([News])->(),errorComp : @escaping ()->()){
        var newsList = [News]()
        
        guard let urlToExecute = URL(string: API.BaseUrl+"/top-headlines") else {
            return
        }
        let networkingClient = NetworkingClient()
        networkingClient.execute(urlToExecute,category:"technology", country: country, apiKey: API.apiKey){(object,error) in
            if object != nil{
                if let object = object {
                    let json = JSON(object)
                    if let jArray = json.array{
                        let articles = (jArray[0])["articles"].array
                        
                        articles?.forEach{news in
                            let newNews = News(name: (news["source"])["name"].string, author: news["author"].string, title: news["title"].string, desc: news["description"].string, url: news["ur;"].string, urlToImage: news["urlToImage"].string, publishedAt: news["publishedAt"].string, content: news["content"].string)
                            
                            newsList.append(newNews)
                        }
                    }
                }
                completion(newsList)
            }
            else{
                errorComp()
            }
        }
        
    }
}
