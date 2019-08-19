//
//  DropDown.swift
//  NostraIos
//
//  Created by Nostra on 8/17/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import UIKit



class DropDownBtn:UIButton,DropDownProtocol{
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
        var code=""
        switch string{
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
        
        view.changeData(country: code)
    }
    
    var view : HomeViewController!
    
    func test(view : HomeViewController){
        self.view=view
    }
    
    var dropView = DropDownView()
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor=UIColor.darkGray
        
        dropView = DropDownView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        dropView.delegete = self
        dropView.translatesAutoresizingMaskIntoConstraints=false
        
        
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isOpen {
            isOpen=true
            NSLayoutConstraint.deactivate([self.height])
            if self.dropView.tableView.contentSize.height > 150{
                self.height.constant = 150
            }
            else{
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height/2
            }, completion: nil)
        }else{
            
            dismissDropDown()
        }
    }
    
    func dismissDropDown(){
        isOpen=false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height/2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DropDownView : UIView,UITableViewDelegate,UITableViewDataSource{
    
    var dropDownopt = [String]()
    
    var tableView = UITableView()
    
    var delegete : DropDownProtocol!
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.backgroundColor = UIColor.darkGray
        tableView.backgroundColor = UIColor.darkGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownopt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dropDownopt[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor=UIColor.darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegete.dropDownPressed(string: dropDownopt[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

