//
//  SWRecorderItemCellTableViewCell.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/21.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWRecorderItemCellTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var statusBtn: UIButton!
    
    typealias ButtonEvent = (UIButton)->()
    
    var ButtonClick:ButtonEvent?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    
    func config()  {
        weak var weakSelf = self
        self.statusBtn.setBackgroundImage("pause".myImage, for: .selected)
        self.statusBtn.setBackgroundImage("play".myImage, for: .normal)
        self.statusBtn.addButtonEvent { (sender) in
            if let callBack = weakSelf!.ButtonClick {
                callBack(sender)
            }
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setNameAndTime(_ year:String?, date:String?, _ name:String?)  {
        guard ((year != nil) && date != nil) else { return  }
        timeLab.text = "\(year!) \(date!)"
        nameLab.text = name
    }
    
}
