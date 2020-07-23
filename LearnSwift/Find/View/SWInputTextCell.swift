//
//  SWInputTextCell.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/7/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit

class SWInputTextCell: SWBaseTableViewCell {
    
    
    
    var buttonEvent:((_ button:UIButton)->(Void))?
    
    var leftLabel = UILabel.init()
    var midTextFiled = UITextField.init()
    var confirmButton = UIButton.init()
    var stateLab = UILabel.init()
    
    override func initUI() {
        super.initUI()
        confirmButton.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        confirmButton.setTitle("保存", for: .normal)
        confirmButton.setTitleColor(.orange, for: .normal)
        self.contentView.addSubview(leftLabel)
        self.contentView.addSubview(midTextFiled)
        self.contentView.addSubview(confirmButton)
        self.contentView.addSubview(stateLab)
    }
    override func initConstraints() {
        super.initConstraints()
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(50)
        }
        midTextFiled.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(leftLabel.snp.right)
            make.right.equalTo(confirmButton.snp.left)
        }
        confirmButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.stateLab.snp.left).offset(-15)
            make.width.equalTo(CGSize(width: 40,height: 60))
        }
        stateLab.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    func set(leftText:String,placeholder:String ,text:String)  {
        leftLabel.text = leftText
        midTextFiled.placeholder = placeholder
        midTextFiled.text = text;
        set(save: text.count > 0)
        
    }
    func set(save:Bool)  {
        if save {
            stateLab.text = "已保存"
            stateLab.textColor = .red
        } else {
            stateLab.text = "未保存"
            stateLab.textColor = .lightGray
        }
    }
    
    @objc func buttonEvent(sender:UIButton) {
        if let buttonEvent = self.buttonEvent {
            print("save event")
            buttonEvent(sender);
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
