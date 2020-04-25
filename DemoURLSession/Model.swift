//
//  NetWorkController.swift
//  DemoURLSession
//
//  Created by Taof on 1/4/20.
//  Copyright © 2020 Taof. All rights reserved.
//

import UIKit

struct User {
    let name: String?
    let profileImageURL: String?
    let repulation: Int?
}

struct Question {
    let title: String
    let score: Int
    let tag: [String]
    let date: Date
    let owner: User?
}

