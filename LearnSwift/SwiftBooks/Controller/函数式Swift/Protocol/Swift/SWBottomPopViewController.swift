//
//  SWBottomPopViewController.swift
//  LearnSwift
//
//  Created by 张君君 on 2020/10/23.
//  Copyright © 2020 com.zhangjunjun.com. All rights reserved.
//

import UIKit
import SnapKit

class SWBottomPopViewController: SWBaseViewController {
    
    var appearView = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        p_initUI()
    }
    
    func p_initUI()  {
        appearView.backgroundColor = .red
        view.addSubview(appearView)
        appearView.setTitle("Close", for: .normal)
        appearView.setTitleColor(.black, for: .normal)
        appearView.addTarget(self, action: #selector(closeEvent(button:)), for: .touchUpInside)
    }
    
    @objc func closeEvent(button:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    public var controllerHeight:CGFloat{
        return 300
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
