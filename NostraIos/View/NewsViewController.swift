//
//  NewsViewController.swift
//  NostraIos
//
//  Created by Nostra on 19/08/19.
//  Copyright © 2019 Nostra. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var test: UILabel!
    
    var a = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test.text=a
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
