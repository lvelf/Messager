//
//  ViewController.swift
//  Messenger
//
//  Created by 诺诺诺诺诺 on 2023/1/31.
//

import UIKit
import FirebaseAuth
import JGProgressHUD


class ConversationsController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet var tableView: UITableView!
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No Conversations"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTapComposeButton))
        
        fetchConversations()
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //check User did log
        validateAuth()
        
    }
    
    private func validateAuth() {
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
        
        
    }
    
    private func configView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConversationCell.self, forCellReuseIdentifier: "ConversationCell")
        
       
        tableView.isHidden = true
        tableView.backgroundColor = .systemGray6
       
        
    }
    
    private func fetchConversations() {
        print("No Hidden")
        tableView.isHidden = false
    }

}
//MARK: - button Actions
extension ConversationsController {
    @objc private func didTapComposeButton() {
        let vc = NewConversationViewController()
        let  navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}

extension ConversationsController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        cell.configConversationCell(message: "Hello World")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("what?")
        let vc = ChatViewController()
        vc.title = "Jenny"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

class ConversationCell: UITableViewCell {
    
    
    func configConversationCell(message: String) {
        self.textLabel?.text = message
        self.accessoryType = .disclosureIndicator
    }
}
