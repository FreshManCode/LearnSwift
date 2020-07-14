//
//  SWDifferentRepresentationVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/6/18.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWDifferentRepresentationVC: SWBaseViewController {
    
    let dogString = "Dog!!🐶"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "不同的表示方法";
        self.p_initDefaultData();
    }
    
    func p_initDefaultData() -> Void {
        self.view.addSubview(self.tableView);
        listArray.append("UTF8Representation");
        listArray.append("UTF16Representation");
        listArray.append("UnicodeScalarRepresentation");
        self.tableView.reloadData();
    }
    
    // MARK: - Event
    @objc func UTF8Representation() {
        /* 可以通过UTF8属性来遍历字符串来获得UTF8表示的结果
         */
        for codeUnit in dogString.utf8 {
            print("\(codeUnit)",terminator:" ")
        }
        //68 111 103 33 33 240 159 144 182
    }
    
    // MARK: - Event
    @objc func UTF16Representation() {
        /* 可以通过UTF16属性来遍历字符串来获得UTF16表示的结果
         */
        for codeUnit in dogString.utf16 {
            print("\(codeUnit)",terminator:" ")
        }
        //68 111 103 33 33 55357 56374
    }
    
    @objc func UnicodeScalarRepresentation() {
        /* 可以通过unicodeScalars属性来遍历字符串来获得unicodeScalars表示的结果
        */
        for codeUnit in dogString.unicodeScalars {
            print("\(codeUnit.value)",terminator:" ")
        }
        //68 111 103 33 33 128054
    }
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    
}
