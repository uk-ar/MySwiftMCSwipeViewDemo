//
//  ViewController.swift
//  MySwiftMCSwipeViewDemo
//
//  Created by 有澤 悠紀 on 2015/02/28.
//  Copyright (c) 2015年 有澤 悠紀. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Tableで使用する配列を設定する
    let myItems: NSArray = ["TEST1", "TEST2", "TEST3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        let myTableView: UITableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewWithImageName(name: String) -> UIView {
        let image: UIImage? = UIImage(named: name);
        let imageView: UIImageView = UIImageView(image: image);
        imageView.contentMode = UIViewContentMode.Center;
        return imageView;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier: String = "cell";
        var cell: MCSwipeTableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as MCSwipeTableViewCell!;
        if cell == nil {
            cell = MCSwipeTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: CellIdentifier);
            cell!.selectionStyle = UITableViewCellSelectionStyle.Gray;
            cell!.contentView.backgroundColor = UIColor.whiteColor();
        }
        
        let checkView: UIView = self.viewWithImageName("check");
        let greenColor: UIColor = UIColor(red: 85.0 / 255.0, green: 213.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0);
        
        let crossView: UIView = self.viewWithImageName("cross");
        let redColor: UIColor = UIColor(red: 232.0 / 255.0, green: 61.0 / 255.0, blue: 14 / 255.0, alpha: 1.0);
        
        let clockView: UIView = self.viewWithImageName("clock");
        let yellowColr: UIColor = UIColor(red: 254.0 / 255.0, green: 217.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0);
        
        let listView = self.viewWithImageName("list");
        let brownColor: UIColor = UIColor(red: 206.0 / 255.0, green: 149.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0);
        
        cell.textLabel?.text = "Switch mode cell";
        cell.detailTextLabel?.text = "Swipe to swich";
        
        cell.setSwipeGestureWithView(checkView, color: greenColor, mode: MCSwipeTableViewCellMode.Exit, state: MCSwipeTableViewCellState.State1, completionBlock:
            
            { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) in   println("Did swipe \"Checkmark\" cell")
                []
        });
        
        cell.setSwipeGestureWithView(crossView, color: redColor, mode: MCSwipeTableViewCellMode.Exit, state: MCSwipeTableViewCellState.State2, completionBlock:
            
            { (cell : MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) in println("Did swipe \"cross\" ");
            }
        )
        
        cell.setSwipeGestureWithView(clockView, color: yellowColr, mode: .Exit, state: .State3) {
            (cell : MCSwipeTableViewCell!, state : MCSwipeTableViewCellState!, mode : MCSwipeTableViewCellMode!) in println("Did swipe \"Clock \"");
        };
        
        cell.setSwipeGestureWithView(listView, color: brownColor, mode: .Switch, state: .State4) {
            (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) in println("Did swipe \"List\" cell");
        }
        return cell;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        //println("Value: \(myItems[indexPath.row])")
    }
}

