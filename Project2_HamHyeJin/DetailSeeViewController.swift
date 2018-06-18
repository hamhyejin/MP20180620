//
//  DetailSeeViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 5. 29..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class DetailSeeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var detailUsername: UILabel!
    @IBOutlet var detailCodename: UILabel!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailProduction: UILabel!
    @IBOutlet var detailEntry: UILabel!
    @IBOutlet var detailContent: UILabel!
    @IBOutlet var detailImage: UIImageView!
    
    var detailProject: NSManagedObject?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let detail = detailProject {
            detailUsername.text = detail.value(forKey: "username") as? String
            detailCodename.text = detail.value(forKey: "codename") as? String
            detailTitle.text = detail.value(forKey: "title") as? String
            detailProduction.text = detail.value(forKey: "production") as? String
            detailEntry.text = detail.value(forKey: "entry") as? String
            detailContent.text = detail.value(forKey: "content") as? String
            detailImage = detail.value(forKey: "image") as? UIImageView
        }
    }
}


