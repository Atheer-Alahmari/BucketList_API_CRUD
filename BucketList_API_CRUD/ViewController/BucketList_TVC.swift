//
//  ViewController.swift
//  BucketList_API_CRUD
//
//  Created by Atheer Alahmari on 23/05/1443 AH.
//

import UIKit

class BucketList_TVC: UITableViewController  , Delegate_Protocol{
    
    let API = "https://saudibucketlistapi.herokuapp.com/tasks/"
    var itemsList = [BuckitList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        get_Api()
    }
    
    
    func get_Api() {
        
        API_Manager.getAllTasks() {
            data, response, error in
            do {
                
                
                self.itemsList = try JSONDecoder().decode([BuckitList].self, from: data!)
                
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    //MARK: ------------------------------------- ( cansel & save ) Pressed --------------------------------------------------

    
    func cansel_Pressed(pressed: AddItem_VC) {
        dismiss(animated: true, completion: nil)
    }
    
    func save_Pressed(pressed: AddItem_VC, text: String, index: NSIndexPath?) {
        if text != ""{
            if  let ip = index {
                API_Manager.putTask(id: itemsList[ip.row].id , objective: text, completionHandler: {
                    data, response, error in
                    self.get_Api()
                    
                })
                
            } else{
                API_Manager.addTaskWithObjective (objective: text , completionHandler:{
                    data, response, error in
                    self.get_Api()
                    
                })
            }
            
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    
//MARK: ------------------------------------- prepare ------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is UIBarButtonItem {
            
            let navegtion  = segue.destination as! UINavigationController
            let add_Item = navegtion.topViewController as! AddItem_VC
            add_Item.delegate = self
        }
        else if sender is IndexPath{
            
            let navegtion  = segue.destination as! UINavigationController
            let add_Item = navegtion.topViewController as! AddItem_VC
            add_Item.delegate = self
            
            let index = sender as! NSIndexPath
            let editItem = itemsList[index.row].objective
            add_Item.item = editItem
            add_Item.index_path = index
        }
        
    }
    
    
    
    
    
    
    // MARK: ----------------------------- Table View ------------------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID_Cell", for: indexPath)
        cell.textLabel?.text = itemsList[indexPath.row].objective
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem_Segue", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
        
        API_Manager.deleteTask(id : itemsList[indexPath.row].id , completionHandler:{
            data, response, error in
            self.get_Api()
            
        })
        
    }
}
