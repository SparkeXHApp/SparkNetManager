//
//  SparkNetPlugin.swift
//  SFKit
//
//  Created by sfh on 2024/3/8.
//

import Moya
import HandyJSON
import NVActivityIndicatorView
import Result

class CheckNetState: PluginType {
    
    lazy var indicator: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView()
        view.type = .circleStrokeSpin
        return view
    }()
    
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
                // 需求要求隐掉
//                SVProgressHUD.showError(withStatus: "网络错误,请检查网络设置")
            }
        } else {
            if isShowLoading {
                DispatchQueue.main.async {
                    self.indicator.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
                    self.indicator.center = UIApplication.shared.windows.first( $0.isKeyWindow )!.center
                    UIApplication.shared.windows.first { $0.isKeyWindow }?.addSubview(self.indicator)
                    self.indicator.startAnimating()
                }
            }
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
        }
//        switch result {
//        case .success(let response):
//            if let json = try? response.mapJSON(),
//               let obj = JSONDeserializer<SparkNetResponse>.deserializeFrom(dict: json as? [String: Any]) {
//                if obj.code == 200 {
//                    if let res = obj.results, res.ret == 100 {
//                        DispatchQueue.main.async {
//                            SVProgressHUD.dismiss()
//                        }
//                    }
//                }
//            }
//            break
//        case .failure(_):
//            break
//        }
    }
}
