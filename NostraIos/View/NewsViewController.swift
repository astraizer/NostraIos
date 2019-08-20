//
//  NewsViewController.swift
//  NostraIos
//
//  Created by Nostra on 19/08/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsSubtitle: UILabel!
    @IBOutlet weak var newsContent: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var newsPublished: UILabel!
    var news:News?

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitle.numberOfLines = 2
        newsTitle.text = news!.title
        
        downloadImage(from: URL(string: news?.urlToImage ?? "https://forum.byjus.com/wp-content/themes/qaengine/img/default-thumbnail.jpg") ?? URL(string : "https://forum.byjus.com/wp-content/themes/qaengine/img/default-thumbnail.jpg")!)
        newsSubtitle.text = news!.desc
        newsContent.numberOfLines = 0
        newsContent.text = news!.content
        newsPublished.text = news!.publishedAt
        newsName.text = news!.name
        newsAuthor.text = news!.author
    }
    

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.newsImage.image = UIImage(data: data)
            }
        }
    }

}
