//
//  DetailShotViewController.swift
//  Project2_HamHyeJin
//
//  Created by 함혜진 on 2018. 6. 10..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class DetailShotViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var detailShotname: UILabel!
    @IBOutlet var detailType: UILabel!
    @IBOutlet var detailStatus: UILabel!
    @IBOutlet var detailVender: UILabel!
    @IBOutlet var detailMemo: UILabel!
    
    var detailShot: NSManagedObject?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sdetail = detailShot {
            detailShotname.text = sdetail.value(forKey: "shotname") as? String
            detailMemo.text = sdetail.value(forKey: "memo") as? String
            detailType.text = sdetail.value(forKey: "type") as? String
            detailStatus.text = sdetail.value(forKey: "status") as? String
            detailVender.text = sdetail.value(forKey: "vender") as? String
        }
    }
    
    @IBAction func BackButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shotView = storyboard.instantiateViewController(withIdentifier: "shotListView")
        self.present(shotView, animated: true, completion: nil)
    }
    
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
    
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

