//
//  CreateViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 6. 3..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var loginStatus: UILabel!
    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var textName: UITextField!
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == self.textID { textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder()
        }
        else if textField == self.textPassword {
            textField.resignFirstResponder()
            self.textName.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func executeRequest (request: URLRequest) -> Void {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in guard responseError == nil else {
            print("Error: calling POST")
            return
            }
            
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return }
            
            if let utf8Data = String(data: receivedData, encoding: .utf8) {
                DispatchQueue.main.async { // for Main Thread Checker
                    print(utf8Data) // php에서 출력한 echo data가 debug 창에 표시됨
                }
            }
        }
        task.resume()
    }
    
    @IBAction func buttonSave() {
        // 필요한 세 가지 자료가 모두 입력 되었는지 확인
        if textID.text == "" {
            let alert = UIAlertController(title: "필수항목이 빠졌습니다.", message: "",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if textPassword.text == "" {
            let alert = UIAlertController(title: "필수항목이 빠졌습니다.", message: "",
                                          preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if textName.text == "" {
            let alert = UIAlertController(title: "필수항목이 빠졌습니다.", message: "",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let urlString: String = "http://condi.swu.ac.kr/student/W13iphone/insertUser.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id=" + textID.text! + "&password=" + textPassword.text!
            + "&name=" + textName.text!
        request.httpBody = restString.data(using: .utf8)
        self.executeRequest(request: request)
        let alert = UIAlertController(title: "계정 생성되었습니다.", message: "로그인하세요:)",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.view.tintColor = UIColor.black
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 5
        subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
        let okAction = (UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            self.performSegue(withIdentifier: "BackLoginView", sender: self)
        }))
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    @IBAction func buttonBack() {
        self.dismiss(animated: true, completion: nil)
    }
}





