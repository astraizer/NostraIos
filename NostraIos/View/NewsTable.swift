//
//  NewsTable.swift
//  NostraIos
//
//  Created by Nostra on 19/08/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import Foundation
import UIKit

class NewsTable : UITableViewDataSource, UITableViewDelegate{
    
    var newsList = [News]()
    init(newsList : [News]) {
        self.newsList = newsList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        
        cell.setNews(news: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
}
