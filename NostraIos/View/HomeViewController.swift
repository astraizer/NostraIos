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
    
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var TableView: UITableView!
    var countryList = [String]()
    var newsList = [News]()
    let networkingClient = NetworkingClient()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var countryCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countryList = ["All","Afganistan","Austria","Indonesia","France"]
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
        countryCode = country
        initData(country: country)
    }
    
    func initData(country:String){
        newsList = [News]()
        TableView.reloadData()
        activityIndicator.startAnimating()
        let homeController = HomeController()
        homeController.getData(country: country, completion: { (newNewsList) in
            self.retryBtn.isHidden = true
            self.newsList = newNewsList
            self.activityIndicator.stopAnimating()
            self.TableView.reloadData()
        },errorComp : {
            self.activityIndicator.stopAnimating()
            self.retryBtn.isHidden = false
            }
        )
    }
    
    @IBAction func retryClick(_ sender: Any) {
        initData(country: countryCode)
        self.retryBtn.isHidden = true
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
        let news = newsList[indexPath.row]
//        vc.news = news
        vc.news = news
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var code=""
        switch countryList[row]{
        case "Afganistan" :
            code = "af"
        case "Austria" :
            code = "at"
        case "Indonesia":
            code = "id"
        case "France" :
            code = "fr"
        default :
            code = ""
        }
        changeData(country: code)
    }
    
}
