//
//  Book.swift
//  ReadFox
//
//  Created by Yerkegali Abubakirov on 16.05.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class Book {

    var title: String!
    var author: String!
    var imageURL: String!
    var pageCount: Int!
    var descript: String!
    var addDate: String!
    var currentPage: Int!
    var lastDate: Int!
    var bookID: String!
    
    init() {}
    
    init(value: NSDictionary) {
        guard let title = value["bookName"] as? String else { return }
        guard let author = value["bookAuthor"] as? String else { return }
        guard let imageURL = value["imageURL"] as? String else { return }
        guard let descript = value["description"] as? String else { return }
        
        self.title = title
        self.author = author
        self.imageURL = imageURL
        self.descript = descript
        self.pageCount = 0
        self.addDate = ""
        self.lastDate = 0
        self.currentPage = 0
        self.bookID = ""
        self.currentPage = 0
        self.pageCount = 0
    }
}
