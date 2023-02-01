//
//  ViewController.swift
//  Messenger
//
//  Created by 诺诺诺诺诺 on 2023/1/31.
//

import UIKit

class ViewController: UITabBarController {
    
    static let shared = ViewController()
    
    //NavigationController and original Controller
    
    /// Conversations Controller
    var conversationsController: ConversationsController = {
        let conversations = ConversationsController()
        return conversations
    }()
    
    var conversationNav: UINavigationController!
    
    /// Setting Controller
    var profileController: ProfileViewController = {
        let profile = ProfileViewController()
        return profile
    }()
    
    var profileNav: UINavigationController!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //config views
        configConversations()
        configProfile()
        
        //config tabbar
        
        self.setViewControllers([conversationNav, profileNav], animated: false)
        
//        guard let items = self.tabBar.items else {
//            return
//        }
        
        self.tabBar.backgroundColor = .white
        
        
    }
    



}

//configuration of controllers

extension ViewController {
    
    private func configConversations() {
        conversationNav = UINavigationController(rootViewController: conversationsController)
        
        //config Navigation Bar
        conversationNav.navigationBar.backgroundColor = .systemGray6
        conversationNav.navigationBar.prefersLargeTitles = true
        
        conversationsController.title = "Chats"
    }
    
    private func configProfile() {
        profileNav = UINavigationController(rootViewController: profileController)
        
        //config Navigation Bar
        profileNav.navigationBar.backgroundColor = .systemGray6
        profileNav.navigationBar.prefersLargeTitles = true
        
        profileController.title = "Profile"
    }
    
}

