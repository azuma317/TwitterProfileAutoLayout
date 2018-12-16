//
//  ViewController.swift
//  AutoLayoutTwitterProfile
//
//  Created by Azuma on 2018/12/13.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    let first = Array(repeating: "First", count: 20)
    let second = Array(repeating: "Second", count: 20)
    let third = Array(repeating: "Third", count: 30)
    let fourth = Array(repeating: "Fourth", count: 40)
    var state = State.first
    
    enum State: Int {
        case first
        case second
        case third
        case fourth
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }

    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        state = State(rawValue: sender.selectedSegmentIndex) ?? .first
        tableView.reloadData()
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        effectView.alpha = offset > 0 ? min(0.8, max(0, (offset-100)/50)) : min(0.8, max(0, -offset/80))
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .first:
            return first.count
        case .second:
            return second.count
        case .third:
            return third.count
        case .fourth:
            return fourth.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch state {
        case .first:
            cell.textLabel?.text = first[indexPath.item]
        case .second:
            cell.textLabel?.text = second[indexPath.item]
        case .third:
            cell.textLabel?.text = third[indexPath.item]
        case .fourth:
            cell.textLabel?.text = fourth[indexPath.item]
        }
        return cell
    }
    
}
