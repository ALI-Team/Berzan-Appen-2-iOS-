//
//  ScheduleWrapperController.swift
//  Berzan
//
//  Created by Luka Janković on 2017-11-04.
//  Copyright © 2017 ALI Team. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Kingfisher

class ScheduleWrapperController:ButtonBarPagerTabStripViewController {
    
    //General view setup
    override func viewDidLoad() {
        setupTabs()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Other UI setup
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        
        /*edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false*/
        
        //iOS 8 & 9
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //Tab setup
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        return [ScheduleViewController(title:NSLocalizedString("week-prefix", comment: "")+" 35", index: 0), ScheduleViewController(title:NSLocalizedString("monday-short", comment: ""), index: 1), ScheduleViewController(title:NSLocalizedString("tuesday-short", comment: ""), index: 2), ScheduleViewController(title:NSLocalizedString("wednesday-short", comment: ""), index: 4), ScheduleViewController(title:NSLocalizedString("thursday-short", comment: ""), index: 8), ScheduleViewController(title:NSLocalizedString("friday-short", comment: ""), index: 16)]
    }
    
    func setupTabs() {
        settings.style.buttonBarBackgroundColor = UIColor(red:0.53, green:0.08, blue:0.22, alpha:1.0)
        settings.style.buttonBarItemBackgroundColor = UIColor(red:0.53, green:0.08, blue:0.22, alpha:1.0)
        settings.style.selectedBarBackgroundColor = UIColor.white
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarItemLeftRightMargin = 2
    }
}

class ScheduleViewController:UIViewController, IndicatorInfoProvider {
    
    var itemIndex: Int
    var itemTitle: String
    var scheduleView: UIImageView?
    
    init(title: String, index: Int) {
        itemTitle = title
        itemIndex = index
        scheduleView = nil
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if scheduleView?.image == nil {
            loadSchedule()
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title:itemTitle)
    }
    
    func initializeInterface() {
        //Imageview
        if scheduleView == nil {
            scheduleView = UIImageView.init()
            
            view.addSubview(scheduleView!)
        }
        
        scheduleView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: scheduleView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scheduleView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: scheduleView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 45))
        view.addConstraint(NSLayoutConstraint(item: scheduleView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    func loadSchedule() {
        
        view.layoutIfNeeded()
        
        let viewHeight = Int((scheduleView?.bounds.height)!)
        let viewWidth = Int((scheduleView?.bounds.width)!)
        
        scheduleView?.kf.indicatorType = .activity
        scheduleView?.kf.setImage(with: URL(string: "http://www.novasoftware.se/ImgGen/schedulegenerator.aspx?format=png&schoolid=89920/\(NSLocalizedString("schedule-lan", comment: ""))&type=-1&id=na15c&period=&week=45&mode=0&printer=0&colors=32&head=0&clock=0&foot=0&day=\(itemIndex)&width=\(viewWidth)&height=\(viewHeight)&maxwidth=\(viewWidth)&maxheight=\(viewHeight)"))
    }
}
