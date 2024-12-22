//
//  View.swift
//  Crypto VIPER
//
//  Created by Sami Gündoğan on 22.12.2024.
//

import Foundation
import UIKit

// talks to -> presenter,
// Class, protocol oriented programming
// ViewController

protocol AnyView {
    var presenter: AnyPresenter? { get set}
    
    func update(with crypto: [Crypto])
    func update(with error: String)
}

class CryptoViewController: UIViewController, AnyView, UITableViewDataSource, UITableViewDelegate {
    
    var presenter: (any AnyPresenter)?
    var cryptos : [Crypto] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .green
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(messageLabel)
        view.addSubview(tableview)
        
    }
    
    private let messageLabel : UILabel = {
        
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = .systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
        
    }()
    
    
    private let tableview : UITableView = {
        
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.isHidden = true
        return tableview
        
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    func update(with crypto: [Crypto]) {
        
        DispatchQueue.main.async {
            
            self.cryptos = crypto
            self.messageLabel.isHidden = true
            self.tableview.isHidden = false
            self.tableview.reloadData()
            
        }
    }
    
    func update(with error: String) {
        
        DispatchQueue.main.async {
            
            self.cryptos = []
            self.messageLabel.isHidden = true
            self.messageLabel.text = error
            self.tableview.isHidden = false
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cryptos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .blue
        return cell
    }
    
}
