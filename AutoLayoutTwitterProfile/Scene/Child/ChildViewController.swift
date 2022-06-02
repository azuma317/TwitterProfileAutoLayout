//
//  ChildViewController.swift
//  AutoLayoutTwitterProfile
//
//  Created by h.crane on 2020/04/29.
//  Copyright © 2020 Azuma. All rights reserved.
//

import UIKit

// MARK: - Controller

final class ChildViewController: UIViewController {
    
    private let index: Int
    private let models = Array(0...20)
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        table.rowHeight = 100
        table.isScrollEnabled = false
        table.dataSource = self
        return table
    }()
    
    init(index: Int) {
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(index: 0)
    }
    
    override func loadView() {
        super.loadView()
        
        view = tableView
    }
}

extension ChildViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        models.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "UITableViewCell",
            for: indexPath
        )
        cell.textLabel?.text = "\(models[indexPath.row])"
        return cell
    }
}
