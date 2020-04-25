//
//  ViewController.swift
//  DemoURLSession
//
//  Created by Taof on 1/4/20.
//  Copyright © 2020 Taof. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let questionURL = "https://api.stackexchange.com/2.2/questions?order=desc&sort=votes&site=stackoverflow"
        
        loadData(urlString: questionURL) { (data) in
            print(data?.count)
        }
    }
    
    // Hàm để load dữ liệu
    func loadData(urlString: String, withCompletion completion: @escaping ([Any]?) -> Void) {
        
        // Khởi tạo cấu hình cho URLSession
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        
        // Khởi tạo và cấu hình URL
        let session = URLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: OperationQueue.main)
        
        // Khởi tạo đối tượng URL
        let url = URL(string: urlString)
        
        // Khởi tạo task để thực hiện việc lấy dữ liệu
        let task = session.dataTask(with: url!) { (data, RLResponse, error) in
            
            // Kiểm tra dữ liệu trả về có bị nil không
            guard let data = data else {
                completion(nil)
                return
            }
            
            // Lấy ra kết quả
            var result: [Any] = []
            
            // Parser data to JSON
            let rawString = String.init(data: data, encoding: String.Encoding.utf8)
            print(rawString!)
            
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let itemArray = json!["items"] as! [Any]
            
            // Duyet tung item de build thanh doi tuong Question
            for item in itemArray {
                let dictItem = item as! [String: Any]
                let dictOwnder = dictItem["owner"] as! [String: Any]
                let name = dictOwnder["display_name"] as! String
                let profileImage = dictOwnder["profile_image"] as? String
                let reputation = dictOwnder["reputation"] as! NSNumber
                
                let user = User(name: name, profileImageURL: profileImage, repulation: reputation.intValue)
                
                let title = dictItem["title"] as! String
                let score = dictItem["score"] as! NSNumber
                let tags = dictItem["tags"] as! [String]
                let date = dictItem["last_edit_date"] as! NSNumber
                
                let realDate = Date.init(timeIntervalSince1970: date.doubleValue)
                
                let question = Question(title: title, score: score.intValue, tag: tags, date: realDate, owner: user)
                
                result.append(question)
                print(user)
            }
            completion(result)
        }
        task.resume()
    }

}

