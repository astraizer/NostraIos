//
//  ViewController.swift
//  NostraIos
//
//  Created by Nostra on 8/17/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    var ddBtn = DropDownBtn()
    var newsList = [News]()
    let networkingClient = NetworkingClient()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initButton()
        initLoading()
        initData(country:"")
        
    }
    func initLoading(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        self.view.addSubview(activityIndicator)
    }
    func changeData(country : String){
        initData(country: country)
    }
    
    func initButton(){
        ddBtn = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        ddBtn.test(view: self)
        ddBtn.setTitle("Country", for: .normal )
        ddBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ddBtn)
        
        ddBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        ddBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive=true
        ddBtn.widthAnchor.constraint(equalToConstant: 160).isActive = true
        ddBtn.heightAnchor.constraint(equalToConstant: 80).isActive=true
        
        ddBtn.dropView.dropDownopt=["Afganistan","Austria","Indonesia","France"]
    }
    
    func initData(country:String){
        newsList = [News]()
        TableView.reloadData()
        
        activityIndicator.startAnimating()
        let homeController = HomeController()
        homeController.getData(country: country, completion: { (newNewsList) in
            self.newsList = newNewsList
            self.activityIndicator.stopAnimating()
            self.TableView.reloadData()
        })
    }

}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
//        let content = newsList[indexPath.row].content
//        if content == nil{
//            vc.a = content!
//        }
//        else{
//            vc.a = "hehe"
//        }
        print(newsList[indexPath.row].content)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

