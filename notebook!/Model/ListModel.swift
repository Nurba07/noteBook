//
//  ListModel.swift
//  notebook!
//
//  Created by Nurbakhyt on 10.08.2023.
//

import Foundation

class ListOfTask {
    var title: String!
    var body: String!
    
    init(list: List){
        self.body = list.body
        self.title = list.title
    }
}
