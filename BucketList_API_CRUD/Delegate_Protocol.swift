//
//  Delegate_Protocol.swift
//  BucketList_API_CRUD
//
//  Created by Atheer Alahmari on 23/05/1443 AH.
//

import Foundation
protocol Delegate_Protocol :class{
    func cansel_Pressed( pressed : AddItem_VC)
    func save_Pressed( pressed : AddItem_VC ,  text : String ,  index : NSIndexPath?)

}
