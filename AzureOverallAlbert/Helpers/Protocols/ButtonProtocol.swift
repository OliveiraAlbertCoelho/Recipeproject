//
//  ButtonProtocol.swift
//  AzureOverallAlbert
//
//  Created by albert coelho oliveira on 4/29/20.
//  Copyright © 2020 albert coelho oliveira. All rights reserved.
//

import Foundation

protocol ButtonProtocol: AnyObject {
   func pressAction(row: Int, section: Int?,  type: ButtonType)
   

}
enum ButtonType  {
   case headerSec1
   case cell
   case headerSec0
}
