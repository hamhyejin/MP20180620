//
//  LoginViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 6. 3..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var loginUserid: UITextField!
    @IBOutlet var loginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.loginUserid {
            textField.resignFirstResponder()
            self.loginPassword.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true }
    
    @IBAction func loginPressed() {
        if loginPassword.text == "" && loginUserid.text == "" {
            let alert = UIAlertController(title: "필수항목을 입력하세요.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if loginUserid.text == "" {
            let alert = UIAlertController(title: "아이디를 입력하세요.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if loginPassword.text == "" {
            let alert = UIAlertController(title: "비밀번호를 입력하세요.", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.view.tintColor = UIColor.black
            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
            subview.layer.cornerRadius = 5
            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let urlString: String = "http://condi.swu.ac.kr/student/W13iphone/loginUser.php"
        guard let requestURL = URL(string: urlString) else {
            return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "id=" + loginUserid.text! + "&password=" + loginPassword.text!
        
        request.httpBody = restString.data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
            }
            
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
            }
            
            do {
                let response = response as! HTTPURLResponse
                if !(200...299 ~= response.statusCode) {
                    print ("HTTP Error!")
                    return
                }
                guard let jsonData = try JSONSerialization.jsonObject(with: receivedData, options:.allowFragments) as? [String: Any] else {
                    print("JSON Serialization Error!")
                    return
                }
                
                guard let success = jsonData["success"] as! String? else {
                    print("Error: PHP failure(success)")
                    return
                }
                
                if success == "YES" {
                    if let name = jsonData["name"] as! String? {
                        DispatchQueue.main.async {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.ID = self.loginUserid.text
                            appDelegate.userName = name
                            //로그인 성공 문구 뜨기
                            let alert = UIAlertController(title:"로그인 성공",message: "환영합니다. 어서오세요:)",preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                self.performSegue(withIdentifier: "toLoginView", sender: self)}))
                            alert.view.tintColor = UIColor.black
                            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
                            subview.layer.cornerRadius = 5
                            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
                            //로그인하지 않으면, 입력한 아이디, 비번 모두 리셋
                            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                            self.loginUserid.text = nil
                            self.loginPassword.text = nil
                        }
                    }
                }else {
                    if let errMessage = jsonData["error"] as! String? {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "로그인 실패", message: "다시 시도하세요:(", preferredStyle: .alert)
                            alert.view.tintColor = UIColor.black
                            let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
                            subview.layer.cornerRadius = 5
                            subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                alert.dismiss(animated: true, completion: nil) }))
                            self.present(alert, animated: true)
                            //return errMessage
                        }
                    }
                }
        }catch {
            print("Error: \(error)")
            
        }
    }
    task.resume()
}
}


