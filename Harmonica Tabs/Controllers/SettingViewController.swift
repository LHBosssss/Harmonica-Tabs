//
//  SettingViewController.swift
//  Harmonica Tabs
//
//  Created by Ho Duy Luong on 5/18/20.
//  Copyright © 2020 Ho Duy Luong. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBar()
    }
    
    func setupBar() {
        // System View Color
        view.backgroundColor = UIColor.randomFlat()
        
        // Tab Bar
        self.navigationController?.tabBarItem.title = "Setting"
        self.navigationController?.tabBarItem.image = UIImage(systemName: "gear")
        
        // Set title
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Setting"
    }

}
