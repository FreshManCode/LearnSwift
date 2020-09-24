//
//  SWPOPTableViewCell.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/9/24.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

enum SWButtonEvent : Int {
    case Favor = 0
    case Collect = 1
}

class SWPOPTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLab: UILabel!
    typealias ButtonEventBlock = (SWButtonEvent)->Void
    var ButtonEvent:ButtonEventBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(model:SWProtocolTestModel)  {
        self.contentLab.text = model.name
    }
    
    @IBAction func doFavor(_ sender: UIButton) {
        callBack(index: .Favor)
    }
    
    
    @IBAction func doCollect(_ sender: Any) {
        callBack(index: .Collect)
    }
    
    func callBack(index:SWButtonEvent)  {
        if let CallBack = ButtonEvent {
            CallBack(index)
        }
    }
}
