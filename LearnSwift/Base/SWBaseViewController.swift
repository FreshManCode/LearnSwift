//
//  SWBaseViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/8.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWBaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count;
    }
    
    // MARK: - TableView--Delegate/DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = self.listArray[indexPath.row];
        let aSelector  = NSSelectorFromString(text)
        if self.responds(to: aSelector) {
            self.perform(aSelector);
        }
    }
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height;
    let navBarHeight    = CGFloat(44.0);
    let maxWidth :CGFloat = CGFloat(UIScreen.main.bounds.size.width);
    let maxHeight:CGFloat = CGFloat(UIScreen.main.bounds.size.height);
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    lazy var tableView: UITableView = {
        let navigationH = statusBarHeight + navBarHeight;
        let table = UITableView.init(frame: CGRect.init(x: 0, y: navigationH, width: maxWidth, height: maxHeight - navigationH), style: UITableView.Style.plain);
        table.delegate = self;
        table.dataSource = self;
        return table;
    }()
    
    lazy var listArray:[String] = {
        let array = [String]();
        return array;
    }()
}
