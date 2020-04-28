//
//  ViewController.swift
//  AutoLayoutTwitterProfile
//
//  Created by Azuma on 2018/12/13.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class ViewController: UIViewController {
    
    var models = ["a", "b", "c"]
    private let selectedIndex: BehaviorRelay<Int> = .init(value: 0)

    @IBOutlet private weak var tabWrapperView: UIStackView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        models.enumerated().forEach { index, txt in
            let btn = UIButton()
            btn.tag = index
            btn.setTitle(txt, for: UIControl.State())
            btn.setTitleColor(.black, for: UIControl.State())
            btn.rx.tap
                .withLatestFrom(Observable.just(index))
                .bind(to: selectedIndex)
                .disposed(by: rx.disposeBag)
            
            tabWrapperView.addArrangedSubview(btn)
        }
        
        selectedIndex
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                
                // todo underbar
                self.tabWrapperView.subviews.forEach { $0.backgroundColor = .white }
                self.tabWrapperView.subviews[index].backgroundColor = .lightGray
                
                // update view
                self.tableView.reloadData()
                self.updateConstraints()
            })
            .disposed(by: rx.disposeBag)
    }
    
    private func updateConstraints() {
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.item)"
        return cell
    }
    
}
