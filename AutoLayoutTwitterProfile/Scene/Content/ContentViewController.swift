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

final class ContentViewController: UIViewController {
    
    var models = ["a", "b", "c"]
    private let currentIndex: BehaviorRelay<Int> = .init(value: 0)
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
            btn.rx.tap
                .withLatestFrom(Observable.just(index))
                .bind(to: currentIndex)
                .disposed(by: rx.disposeBag)
            
            contentView.tabWrapperView.addArrangedSubview(btn)
            
            let vc = ChildViewController(viewModel: index)
            contentView.controllers.append(vc)
        }
        
        currentIndex
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                
                // todo underbar
                self.contentView.tabWrapperView.subviews.forEach { $0.backgroundColor = .white }
                self.contentView.tabWrapperView.subviews[index].backgroundColor = .lightGray
                
                // update view
                self.setController(by: index)
                self.setConstraints(by: index)
            })
            .disposed(by: rx.disposeBag)
    }
    
    func setConstraints(by index: Int) {

        contentView.containerHeight.constant
            = (contentView.controllers[index].view as? UITableView)?.contentSize.height ?? 0
        view.layoutIfNeeded()
        
        // todo 高さが初回でセットされない。　スクロールのバッティングが発生する
        debugPrint("---", (contentView.controllers[index].view as? UITableView)?.contentSize)
    }
    
    func setController(by index: Int) {
        
        
        // todo calculate direction
        contentView.pageViewController.setViewControllers([contentView.controllers[index]], direction: .forward, animated: true)
    }
}
