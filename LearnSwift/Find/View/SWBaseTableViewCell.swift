//
//  SWBaseTableViewCell.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/7/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import SnapKit

class SWBaseTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        initConstraints()
    }
    
    func initUI()  {
        
    }
    
    func initConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc class func CellID()->String {
        return NSStringFromClass(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
