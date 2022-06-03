//
//  ViewController.swift
//  AutoLayoutTwitterProfile
//
//  Created by Azuma on 2018/12/13.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

final class ContentViewController: UIViewController {
    
    var models = ["a", "b", "c"]
    var currentIndex = 0
    var pointCache = [Int: IndexPath]()
    private let contentView: ContentView = .instantiate()
    
    override func loadView() {
        super.loadView()
        
        bind()
        initialize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setConstraints(by: 0)
    }
}

// MARK: - UITableViewDelegate
extension ContentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint(#function, indexPath)
    }
}

// MARK: - Private
private extension ContentViewController {
    
    func initialize() {
        view = contentView
        addChild(contentView.pageViewController)
        contentView.pageViewController.didMove(toParent: self)
        setController(by: 0)
    }
    
    func bind() {
        models.enumerated().forEach { index, txt in
            let btn = UIButton()
            btn.tag = index
            btn.setTitle(txt, for: UIControl.State())
            btn.setTitleColor(.black, for: UIControl.State())
            btn.addTarget(self, action: #selector(didTapTab), for: .touchUpInside)
            contentView.tabWrapperView.addArrangedSubview(btn)
            
            let vc = ChildViewController(index: index)
            vc.tableView.delegate = self
            vc.tableView.reloadData()
            contentView.children.append(vc)
        }
    }

    func setController(by index: Int) {
        contentView.pageViewController.setViewControllers(
            [contentView.children[index]],
            direction: .forward, // todo calculate direction
            animated: true
        )
    }

    func setConstraints(by index: Int) {
        let table = contentView.children[index].view as? UITableView
        let height = table?.contentSize.height ?? 0
        view.layoutIfNeeded()
        contentView.containerHeight.constant = height
    }

    @objc func didTapTab(_ button: UIButton) {
        currentIndex = button.tag

        contentView.tabWrapperView.subviews.forEach { $0.backgroundColor = .white }
        contentView.tabWrapperView.subviews[button.tag].backgroundColor = .lightGray

        setController(by: button.tag)
        setConstraints(by: button.tag)
    }
}

