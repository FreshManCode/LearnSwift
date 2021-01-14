//
//  SWDisplayAppstoreVC.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/13.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import UIKit
///内部弹出Appstore页面
import StoreKit
class SWDisplayAppstoreVC: SWBaseViewController, SKStoreProductViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        p_initDefautData()
    }
    
    func p_initDefautData()  {
        self.title = "AppStore展示方式"
        view.addSubview(tableView)
        listArray.append("ToAppStore")
        listArray.append("DisplayWebAppstore")
//        listArray.append("TestPresent")
        tableView.reloadData()
    }
    
    
    private func toAppStore () {
        let wexWallet = "itms-apps://itunes.apple.com/app/id1055222439"
        guard let url = URL(string: wexWallet) else { return  }
        let can = UIApplication.shared.canOpenURL(url)
        if can {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:]) { (result) in
                    print("result is:",result)
                }
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    private func displayWebAppstore () {
        let storeVC = SKStoreProductViewController()
        storeVC.modalPresentationStyle = .fullScreen
        storeVC.delegate = self
        self.present(storeVC, animated: true, completion: nil)
        let param = [SKStoreProductParameterITunesItemIdentifier:"1055222439"]
        storeVC.loadProduct(withParameters: param) { (result, error) in
            printLog("result is:",result)
            if let error = error {
                printLog("加载错误:",error)
            }
        }
    }
    
    
    @objc func TestPresent () {
        let presentVC = SWDisplayAppstoreVC()
        let presentNav = SWBaseNavigationController(rootViewController: presentVC)
        presentNav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(presentNav, animated: true, completion: nil)
    }
    
    
    // MARK: - 直接前往Appsotore
    @objc  func ToAppStore()  {
        weak var weakSelf = self
        showAlert(text: "前往AppStore") { () -> (Void) in
            weakSelf?.toAppStore()
        }
    }
    
    // MARK: - 弹出Appstore web页
    @objc  func DisplayWebAppstore()  {
        weak var weakSelf = self
        showAlert(text: "弹出AppStore") { () -> (Void) in
            weakSelf?.displayWebAppstore()
        }
    }
    
    // MARK: - TableView--Delegate/DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SWDifferentCell.cellWithTableView(text: listArray[indexPath.row], tableView: tableView);
    }
    
    // MARK: - SKStoreProductViewControllerDelegate

    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func psuhToTargetVC(className:String)  {
        let modelClass: AnyClass? = NSClassFromString("LearnSwift.\(className)")
        if let VCClass = modelClass as? UIViewController.Type {
            let vcInstance = VCClass.init()
            navigationController?.pushViewController(vcInstance, animated: true)
        }
    }
    

}
