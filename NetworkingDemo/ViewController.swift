//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Tung Vu Duc on 17/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        APIService.shared.loadPosts { posts in
            print("loading completed")
            
        }
        
    }

    

}

struct Post: Decodable {
    let id: String
    let userId: Int
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case title
        case description = "body"
    }
}

class APIService {
    private init() {}
    
    static let shared = APIService()
    
    func loadPosts(completion: @escaping ([Post]) -> Void){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                // handle error here
                return
            }
            if let upwrappedResponse = response as? HTTPURLResponse,
               upwrappedResponse.statusCode == 200,
               let data = data,
               let posts = try? JSONDecoder().decode([Post].self, from: data){
            }
        }
        
        dataTask.resume()
    }
}

