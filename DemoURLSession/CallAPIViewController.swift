//
//  CallAPIViewController.swift
//  DemoURLSession
//
//  Created by Taof on 4/25/20.
//  Copyright © 2020 Taof. All rights reserved.
//

import UIKit

struct Person: Codable {
    let id: Int
    var name, email, password, phone: String?
    let birthDay, gender: String?
    let avatar: String
}

class CallAPIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let url = URL(string: "https://apis-fake.herokuapp.com/users")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            let rawString = String.init(data: data, encoding: String.Encoding.utf8)
            
            do {
                let recivedData = try JSONDecoder().decode([Person].self, from: data)
                for item in recivedData {
                    print("\(item.id), \(item.name)")
                }
                
            } catch {
                print(error)
            }
        }
        dataTask.resume()    }

}
