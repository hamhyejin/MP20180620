
//
//  RootTableViewController.swift
//  Project2_HamHyeJin
//
//  Created by 유지혜 on 2018. 5. 28..
//  Copyright © 2018년 Computer Science. All rights reserved.
//

import UIKit
import CoreData

class RootTableViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
 //   var fetchedArray: [FavoriteData] = Array()
    var project: [NSManagedObject] = []
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Table view data source
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  fetchedArray = [] // 배열을 초기화하고 서버에서 자료를 다시 가져옴
        //self.downloadDataFromServer()
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Projects")
        
        let sortDescriptor = NSSortDescriptor (key: "codename", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            project = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)") }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            self.title = name + "'s Project List"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 5
        subview.backgroundColor = UIColor(red: (60/255.0), green: (141/255.0), blue: (87/255.0), alpha: 1.0)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let urlString: String = "http://condi.swu.ac.kr/student/W13iphone/logout.php"
            guard let requestURL = URL(string: urlString) else {
                return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else {
                    return }
            }
            task.resume()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginView = storyboard.instantiateViewController(withIdentifier: "LoginView")
            self.present(loginView, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return fetchedArray.count
        return project.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Project Cell", for: indexPath)
        
        let pproject = project[indexPath.row]
        var display: String = ""
        
        if let pcodename = pproject.value(forKey: "codename") as? String {
        display = pcodename }
        if let pprojectname = pproject.value(forKey: "title") as? String {
            display = display + " " + pprojectname }
        
        cell.textLabel?.text = display
        cell.detailTextLabel?.text = pproject.value(forKey: "content") as? String
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // 배열에서 해당 자료 삭제
        let context = getContext()
        context.delete(project[indexPath.row])
        do {
            try context.save()
            print("deleted!")
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
        }
        project.remove(at: indexPath.row)
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     }
     /*(
     else if editingStyle == .insert {*/
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
 
    /*
     }
    (
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSeeView" {
            if let destination = segue.destination as? DetailSeeViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailProject = project[selectedIndex]
                }
            }
        }
    }
}

