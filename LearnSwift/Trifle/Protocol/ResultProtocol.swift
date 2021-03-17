//
//  ResultProtocol.swift
//  LearnSwift
//
//  Created by 张君君 on 2021/1/12.
//  Copyright © 2021 com.zhangjunjun.com. All rights reserved.
//

import Foundation

public protocol LWSuccessProtocol {
    
}

public protocol LWFailedProtocol {
    
}

public enum LWResult<T:LWSuccessProtocol,Error:LWFailedProtocol> {
    case success(T)
    case failure(Error)
    public init(value:T) {
        self = .success(value)
    }
    
    public init(error:Error) {
        self = .failure(error)
    }
}

public class LWMySuccess:LWSuccessProtocol  {
    var  isSuccess:Bool {
        printLog("this is LWMySuccess Log")
        return true
    }
    
}

public class LWMyError:LWFailedProtocol  {
    var  isError:Bool {
        printLog("this is LWMyError Log")
        return true
    }
}

