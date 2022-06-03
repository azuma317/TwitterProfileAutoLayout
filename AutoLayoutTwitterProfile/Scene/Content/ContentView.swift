//
//  ContentView.swift
//  AutoLayoutTwitterProfile
//
//  Created by h.crane on 2020/04/29.
//  Copyright © 2020 Azuma. All rights reserved.
//

import UIKit
import Foundation

final class ContentView: UIView {
    
    // MARK: Properties
    
    var children = [UIViewController]()
    
    lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal,
        options: nil
    )
    
    // MARK: IBOutlets
    
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tabWrapperView: UIStackView!
    @IBOutlet weak var pageWrapperView: UIView! {
        didSet {
            pageWrapperView.equalToParentConstraint(for: pageViewController.view)
        }
    }
}
