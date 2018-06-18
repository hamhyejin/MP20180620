//
//  ShotCreateViewController.swift
//  Project2_HamHyeJin
//
//  Created by 함혜진 on 2018. 5. 29..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class ShotCreateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var sName: UITextField!
    @IBOutlet var sstatus: UISegmentedControl!
    @IBOutlet var svender: UISegmentedControl!
    @IBOutlet var stype: UISegmentedControl!
    @IBOutlet var smemo: UITextView!
    @IBOutlet var scode: UITextField!
    
    var segvender: String = ""
    var segtype: String = ""
    var segstatus: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //delegate method
        textField.resignFirstResponder()
        smemo.becomeFirstResponder()
        return true
    }
    
    @IBAction func saveSegment(_ sender: UISegmentedControl) {
        segvender = svender.titleForSegment(at: sender.selectedSegmentIndex)!
    }
    
    @IBAction func saveSegment1(_ sender: UISegmentedControl) {
        segstatus = sstatus.titleForSegment(at: sender.selectedSegmentIndex)!
    }
    
    @IBAction func saveSegment2(_ sender: UISegmentedControl) {
        segtype = stype.titleForSegment(at: sender.selectedSegmentIndex)!
    }
    
    //saveButton function
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Shots", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(scode.text, forKey: "codeseparate")
        object.setValue(segstatus, forKey: "status")
        object.setValue(segtype, forKey: "type")
        object.setValue(segvender, forKey: "vender")
        object.setValue(sName.text, forKey: "shotname")
        object.setValue(smemo.text, forKey: "memo")
        
        //반드시 코드명을 선택할 수 있도록 경고 날림 띄우기
        if (scode.text == "") {
            let alert = UIAlertController(title: "코드명을 입력하세요", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil) }))
            self.present(alert, animated: true)
            return }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "toView"{
     let destination = segue.destination as! DetailShotViewController
     destination.lastVender = svender.titleForSegment(at: svender.selectedSegmentIndex)!
     destination.lastStatus = sstatus.titleForSegment(at: sstatus.selectedSegmentIndex)!
     destination.lastType = stype.titleForSegment(at: stype.selectedSegmentIndex)!
     }
     }*/
}


