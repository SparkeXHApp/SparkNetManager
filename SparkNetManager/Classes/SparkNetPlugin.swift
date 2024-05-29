//
//  SparkNetPlugin.swift
//  SFKit
//
//  Created by sfh on 2024/3/8.
//

import Moya
import HandyJSON
import SVProgressHUD
import Result

class CheckNetState: PluginType {
    
    fileprivate func getUserDefValue(_ key: String) -> String? {
        if let value = UserDefaults.standard.object(forKey: key) as? String {
            return value
        } else {
            return ""
        }
    }
    
    /// 在通过网络发送请求(或存根)之前立即调用
    func willSend(_ request: RequestType, target: TargetType) {
        // AppDelegate里使用的AFN获取网络状态后存缓存，所以这里就直接取缓存了，后续可以抽出来
        if getUserDefValue("NetStatus") == "None" || getUserDefValue("NetStatus") == "UNKNOWN" || getUserDefValue("NetStatus") == "" {
            SparkNetManager.APIProvider.manager.session.delegateQueue.cancelAllOperations()
            DispatchQueue.main.async {
                SVProgressHUD.showError(withStatus: "网络错误,请检查网络设置")
            }
        } else {
            if isShowLoading {
                DispatchQueue.main.async {
                    SVProgressHUD.show()
                }
            }
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if let json = try? response.mapJSON(),
               let obj = JSONDeserializer<SparkNetResponse>.deserializeFrom(dict: json as? [String: Any]) {
                if obj.code == 200 {
                    if let res = obj.results, res.ret == 100 {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                        }
                    }
                }
            }
            break
        case .failure(_):
            break
        }
    }
}
