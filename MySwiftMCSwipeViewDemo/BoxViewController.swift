//
//  BoxViewController.swift
//  UIKit013
//
//

import UIKit

class BoxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var unreadItems = ["TEST1", "TEST2", "TEST3"]
    var tableView :UITableView!
    override init() {
        super.init()
        
        // Viewの背景色をCyanに設定する.
        self.view.backgroundColor = UIColor.cyanColor()
        
        //tabBarItemのアイコンをFeaturedに、タグを1と定義する.
        self.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Featured, tag: 1)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        let tableView = UITableView(frame:CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        tableView.dataSource = self
        
        // Delegateを設定する.
        tableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(tableView)
        self.tableView = tableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewWithImageName(name: String) -> UIView {
        let image: UIImage? = UIImage(named: name);
        let imageView: UIImageView = UIImageView(image: image);
        imageView.contentMode = UIViewContentMode.Center;
        return imageView;
    }
    
    func deleteCell(cell: MCSwipeTableViewCell)->NSString{
        let indexPath:NSIndexPath=self.tableView.indexPathForCell(cell)!
        let result=unreadItems.removeAtIndex(indexPath.row)
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        return result
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellIdentifier: String = "cell";
        var cell: MCSwipeTableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as MCSwipeTableViewCell!;
        if cell == nil {
            cell = MCSwipeTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: CellIdentifier);
            
            // Remove inset of iOS 7 separators.
            if cell.respondsToSelector(Selector("separatorInset")){
                cell.separatorInset=UIEdgeInsetsZero;
            }
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
        
        cell.textLabel?.text = "\(unreadItems[indexPath.row])"
        //cell.textLabel?.text = "Switch Mode Cell"
        cell.detailTextLabel?.text = "Swipe to swich";
        
        cell.setSwipeGestureWithView(checkView, color: greenColor,
            mode: MCSwipeTableViewCellMode.Exit, state: MCSwipeTableViewCellState.State1,
            completionBlock:
            { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState, mode:MCSwipeTableViewCellMode) in
                println("Did swipe \"Checkmark\" cell")
                self.deleteCell(cell)
        });
        
        //        cell.setSwipeGestureWithView(crossView, color: redColor,
        //            mode: MCSwipeTableViewCellMode.Exit, state: MCSwipeTableViewCellState.State2,
        //            completionBlock:
        //            { (cell : MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) in
        //                println("Did swipe \"cross\" ");
        //                //archive
        //            }
        //        )
        
        cell.setSwipeGestureWithView(clockView, color: yellowColr, mode: .Exit, state: .State3) {
            (cell : MCSwipeTableViewCell!, state : MCSwipeTableViewCellState, mode : MCSwipeTableViewCellMode) in
            println("Did swipe \"Clock \"")
            self.deleteCell(cell)
        };
        cell.modeForState3=MCSwipeTableViewCellMode.None
        //        cell.setSwipeGestureWithView(clockView, color: yellowColr, mode: .None, state: .State3 ,completionBlock:nil)
        //        cell.setSwipeGestureWithView(listView, color: brownColor, mode: .Switch, state: .State4) {
        //            (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) in println("Did swipe \"List\" cell");
        //        }
        return cell;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unreadItems.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Num: \(indexPath.row)")
        //println("Value: \(myItems[indexPath.row])")
    }
}
