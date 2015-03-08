//
//  UnreadViewController.swift
//  
//
//  Created by 有澤 悠紀 on 2015/03/09.
//
//

import UIKit

class UnreadViewController: BoxViewController {
    
    override init() {
        super.init()
        
        // Viewの背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.redColor()
        
        // tabBarItemのアイコンをFeaturedに、タグを2と定義する.
        self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Featured, tag: 3)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

