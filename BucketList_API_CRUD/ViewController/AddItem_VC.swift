//
//  AddItem_VC.swift
//  BucketList_API_CRUD
//
//  Created by Atheer Alahmari on 23/05/1443 AH.
//

import UIKit

class AddItem_VC: UITableViewController {

    @IBOutlet weak var item_TF: UITextField!
    
    
    weak var delegate : Delegate_Protocol?
    var item : String?
    var index_path: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  item != nil{
            item_TF.placeholder = "Please update your item "
            item_TF.text = item
        }
       

        // Do any additional setup after loading the view.
    }
    

 
    @IBAction func cancel_Action(_ sender: UIBarButtonItem) {
        delegate?.cansel_Pressed(pressed: self)
    }
    
    @IBAction func save_Action(_ sender: UIBarButtonItem) {
        let newitem = item_TF.text!
 
        delegate?.save_Pressed(pressed: self, text : newitem, index : index_path)
    }
   
    
}
