//
//  SWBaseViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/8.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBaseViewController: UIViewController {
    
    
    
    var startIndex:Int = 0
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44;
//    }
    
   
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height;
    let navBarHeight    = CGFloat(44.0);
    let maxWidth :CGFloat = CGFloat(UIScreen.main.bounds.size.width);
    let maxHeight:CGFloat = CGFloat(UIScreen.main.bounds.size.height);
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        printLog("\(self) deinit")
    }
    
    lazy var tableView: UITableView = {
        let navigationH = statusBarHeight + navBarHeight;
        let table = UITableView.init(frame: CGRect.init(x: 0, y: navigationH, width: maxWidth, height: maxHeight - navigationH), style: UITableView.Style.plain);
        table.delegate = self;
        table.dataSource = self;
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        //        table.estimatedRowHeight = 100.0
        //        table.rowHeight = UITableView.automaticDimension
        return table;
    }()
    
    
    lazy var listArray:[String] = {
        let array = [String]()
        return array;
    }()
    
    
    lazy var listItemArray:[SWBookListItem] = {
        let array = [SWBookListItem]()
        return array;
    }()
   
}


extension SWBaseViewController:UITableViewDelegate,UITableViewDataSource {
    // MARK: - TableView--Delegate/DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listArray.count > indexPath.row {
            return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row],
                                                     tableView: tableView);
        }
        else if listItemArray.count > indexPath.row {
            return SWDifferentCell.cellWithTableView(text: listItemArray[indexPath.row].title!,
                                                     tableView: tableView);
        }
        return SWDifferentCell.cellWithTableView(text: "MayError",
                                                 tableView: tableView);
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count > 0 ? listArray.count : listItemArray.count;
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listArray.count < 1 && listItemArray.count < 1  {
            return
        }
        var text = ""
        if indexPath.row < listArray.count {
            text = self.listArray[indexPath.row];
        }
        else if indexPath.row < listItemArray.count {
            text = listItemArray[indexPath.row].funName!
        }
        let aSelector  = NSSelectorFromString(text)
        if self.responds(to: aSelector) {
            self.perform(aSelector);
        }
    }
}
