//
//  ProfileViewController.swift
//  Messenger
//
//  Created by 诺诺诺诺诺 on 2023/1/31.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let datas = ["退出登录"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
       
        
    }
    
    private func configView() {
        
        //basic config
        tableView = UITableView(frame: view.bounds)
        tableView.backgroundColor = .systemGray6
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        
    }

}


//basic tableView configuration
extension ProfileViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
        cell.configMyCell(text: datas[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        sendAlertMessage(message: "")
    }
}

extension ProfileViewController {
    //send alert message
    private func sendAlertMessage(message: String) {
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: {[weak self] _ in
            guard let strongSelf = self else {
                return
            }
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
            }
            catch {
                print("Failed to log out")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func logOut() {
        print("hh")
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
        catch {
            print("Failed to log out")
        }
    }
}

class MyCell: UITableViewCell {
    
    func configMyCell(text: String) {
        self.textLabel?.text = text
        self.textLabel?.textAlignment = .center
        self.textLabel?.textColor = .black
    }
}




