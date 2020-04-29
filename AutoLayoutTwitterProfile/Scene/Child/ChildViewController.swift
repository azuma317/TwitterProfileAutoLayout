//
//  ChildViewController.swift
//  AutoLayoutTwitterProfile
//
//  Created by h.crane on 2020/04/29.
//  Copyright © 2020 Azuma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Controller

final class ChildViewController: UIViewController {
    
    private let viewModel: Int
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 100
        table.isScrollEnabled = false
        
        Observable
            .just(["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""])
            .bind(to: table.rx.items) { table, row, element in
                let cell = UITableViewCell()
                cell.textLabel?.text = "\(self.viewModel) cell"
                return cell
            }
            .disposed(by:rx.disposeBag)
        
        return table
    }()
    
    init(viewModel: Int) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(viewModel: 0)
    }
    
    override func loadView() {
        super.loadView()
        
        view = tableView
    }
}
