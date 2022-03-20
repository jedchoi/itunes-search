//
//  TodayViewController.swift
//  itunes-search
//
//  Created by JaeHyuk Choi on 2022/03/20.
//

import UIKit

class TodayViewController: UIViewController, TabBarInterface {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configuredViewController() -> UIViewController {
        return self
    }
}

