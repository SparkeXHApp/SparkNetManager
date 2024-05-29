//
//  NetworkExampleViewController.swift
//  SparkBase
//
//  Created by sfh on 2023/12/25.
//  Copyright © 2023 Spark. All rights reserved.
//

import UIKit
import HandyJSON

/// 底部导航模型
struct TabbarInfoModel: HandyJSON {
    /// 详情跳转id
    var id: String?
    /// 广告图片url
    var img: String?
    /// 名称
    var name: String?
    /// 协议链接
    var url: String?
    /// 是否可用
    var enable: Bool?
    /// 预留字段1
    var img_normal: String?
    /// 预留字段2
    var img_press: String?
    /// 预留字段3
    var force_login: String?
    /// 预留字段4
    var isShow: Bool?
    /// 预留字段5
    var state: String?
}

/// 内容列表模型
struct listInfoModel: HandyJSON {
    var list: [infoListModel]?
    
    struct infoListModel: HandyJSON {
        /// 详情跳转id
        var id: String?
        /// 广告图片url
        var img: String?
        /// 名称
        var name: String?
        /// 协议链接
        var url: String?
        /// 是否可用
        var enable: Bool?
    }
    
}

/// 版本升级模型
struct upgradeInfoModel: HandyJSON {
    /// 安装包路径
    var apkPath: String?
    /// 版本编码
    var serverVersionCode: String?
    /// 版本名称
    var serverVersionName: String?
    /// 包名
    var appPackageName: String?
    /// 更新标题
    var updateInfoTitle: String?
    /// 更新内容
    var updateInfo: String?
    /// 包名md5
    var md5: String?
    /// 是否强制更新
    var isForce: Bool?
    /// 更新背景图
    var upgradeBackImg: String?
    /// 应用名称
    var applicationLable: String?
}

class NetworkExampleViewController: UIViewController {
    
    var infoList:[String] = ["底部导航", "轮播图", "分类菜单", "内容列表", "分页内容列表", "版本升级"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 查询底部导航
        let target = BasicAPIService.tabbarInfo(parameters: ["id": "业务模块id", "other": "其他需要参数"])
        SparkNetManager.request(target: target) { msg, res, list in
            print("请求成功")
        } failure: { error in
            print("请求失败")
        }

        /// 查询轮播图
        let target1 = BasicAPIService.bannerInfo(parameters: ["navigationBtmId": "底部导航id", "id": "业务模块id"])
        SparkNetManager.request(target: target1) { msg, res, list in
            print("请求成功")
        } failure: { error in
            print("请求失败")
        }
        
        /// 查询分类菜单
        let target2 = BasicAPIService.categoryInfo(parameters: ["navigationBtmId": "底部导航id", "id": "业务模块id", "userId": "用户id"])
        SparkNetManager.request(target: target2) { msg, res, list in
            print("请求成功")
        } failure: { error in
            print("请求失败")
        }
        
        /// 查询内容列表
        let target3 = BasicAPIService.listInfo(parameters: ["navigationBtmId": "底部导航id", "id": "业务模块id", "categoryId": "二级分类id"])
        SparkNetManager.request(target: target3) { msg, res, list in
            print("请求成功")
        } failure: { error in
            print("请求失败")
        }
        
        /// 查询分页内容列表
        let target4 = BasicAPIService.pageListInfo(parameters: ["navigationBtmId": "底部导航id", "id": "业务模块id", "categoryId": "二级分类id", "pageNum": "页码", "pageSize": "每页条数"])
        SparkNetManager.request(target: target4) { msg, res, list in
            print("请求成功")
        } failure: { error in
            print("请求失败")
        }
        
        /// 查询版本升级
        let target5 = BasicAPIService.upgradeInfo(parameters: ["serverVersionName": "版本名称", "appPackageName": "包名", "serverVersionCode": "版本号", "md5": "包名对应的md5值 32位小写", "id": "应用id"])
        SparkNetManager.request(target: target5) { msg, res, list in
            print("请求成功")
        } failure: { error in
            print("请求失败")
        }

    }

}
