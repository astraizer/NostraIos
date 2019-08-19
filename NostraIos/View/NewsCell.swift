//
//  NewsCell.swift
//  NostraIos
//
//  Created by Nostra on 8/17/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var NewsTitle: UILabel!
    
    func setNews(news:News){
        downloadImage(from: URL(string: news.urlToImage ?? "https://forum.byjus.com/wp-content/themes/qaengine/img/default-thumbnail.jpg") ?? URL(string : "https://forum.byjus.com/wp-content/themes/qaengine/img/default-thumbnail.jpg")!)
        NewsTitle.text = news.title
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.photoImage.image = UIImage(data: data)
            }
        }
    }
    
    
    
}
