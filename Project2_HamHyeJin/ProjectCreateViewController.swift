//
//  ProjectCreateViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 5. 28..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class ProjectCreateViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var ptitle: UITextField!
    @IBOutlet var puser: UITextField!
    @IBOutlet var pcode: UITextField!
    @IBOutlet var ppd: UITextField!
    @IBOutlet var pentry: UITextField!
    @IBOutlet var pmemo: UITextField!
    
    @IBOutlet var Thumnail: UIImageView!
    @IBOutlet var buttonCamera: UIButton!
    
    //var imageimage: UIImage? = nil
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let alert = UIAlertController(title: "Error!!", message: "Device has no Camera!", preferredStyle: .alert)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            buttonCamera.isEnabled = false // 카메라 버튼 사용을 금지시킴
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func camera(_ sender: UIButton) {
        
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.allowsEditing = true
        myPicker.sourceType = .camera
        self.present(myPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func album(_ sender: UIButton) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.Thumnail.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Projects", in: context)
        // project record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        //let data = UIImagePNGRepresentation(Thumnail.image!) as NSData?
        //let imageload = UIImage(data: data! as Data)
        
        object.setValue(ptitle.text, forKey: "title")
        object.setValue(pcode.text, forKey: "codename")
        object.setValue(puser.text, forKey: "username")
        object.setValue(ppd.text, forKey: "production")
        object.setValue(pentry.text, forKey: "entry")
        object.setValue(pmemo.text, forKey: "content")
        //object.setValue(myImage.images, forKey: "image")
        
        if (puser.text == "" || pcode.text == "") {
            let alert = UIAlertController(title: "담당자|프로젝트명을 입력하세요", message: "", preferredStyle: .alert)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil) }))
            self.present(alert, animated: true)
            return }
        
        guard let myImage = Thumnail.image else {
            let alert = UIAlertController(title: "이미지를 선택하세요", message: "Save Failed!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil) }))
            self.present(alert, animated: true)
            return }
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)") }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
}


