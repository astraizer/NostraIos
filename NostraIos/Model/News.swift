//
//  News.swift
//  NostraIos
//
//  Created by Nostra on 8/17/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import UIKit

class News{
    let name : String?
    let author: String?
    let title: String?
    let desc : String?
    let url : String?
    let urlToImage : String?
    let publishedAt: String?
    let content : String?
    
    init(name:String?, author:String?, title:String?, desc:String?, url:String?, urlToImage:String? ,publishedAt:String?, content:String?) {
        self.name = name
        self.author = author
        self.title = title
        self.desc = desc
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
}
