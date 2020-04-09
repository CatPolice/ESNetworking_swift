//
//  ESNetworking.swift
//  ESNetworking_swift
//
//  Created by codeLocker on 2020/4/9.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit
import Alamofire

//https://www.jianshu.com/p/4381fe8e10b6

class ESNetworking: NSObject {
    
    /// 是否打印日志
    public static var enableLog: Bool = false
    
    /// headers 转成 HTTPHeaders
    /// - Parameter headers: headers
    /// - Returns: HTTPHeaders
    static func transformHeaders(from headers: [String: String]?) -> HTTPHeaders? {
        guard let headers = headers else {
            return nil
        }
        if headers.keys.count == 0 {
            return nil
        }
        var httpHeaders = HTTPHeaders()
        for key in headers.keys {
            let value = headers[key]
            if value == nil {
                continue
            }
            httpHeaders.add(HTTPHeader.init(name: key, value: value!))
        }
        return httpHeaders
    }
    
    /// 打印接口信息
    /// - Parameters:
    ///   - url: 地址
    ///   - params: 参数
    ///   - headers: 请求头
    static func printAPI(url: String, params: [String: Any]? = nil, headers: [String: String]? = nil) {
        if self.enableLog {
            print("🔥🔥🔥🔥🔥🔥 网络请求 🔥🔥🔥🔥🔥🔥")
            print("🚀接口: \(url)")
            print("🏀参数: \(params ?? [String: Any]())")
            print("🎩头: \(headers ?? [String: Any]())")
        }
    }
    
    /// 打印返回数据
    /// - Parameter response: 数据
    static func printResponse(_ response: [String: Any]?) {
        if self.enableLog {
            if response == nil {
                print("❎数据: 解析失败")
            } else {
                print("✅数据: \(response!)")
            }
        }
    }
    
    /// 打印错误
    /// - Parameter error: 错误
    static func printError(_ error: AFError?) {
        if self.enableLog {
            print("❌错误: \(error?.localizedDescription ?? "未知异常")")
        }
    }
    
    /// GET请求
    /// - Parameters:
    ///   - url: 请求骶椎
    ///   - params: 参数
    ///   - headers: 请求头
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public static func get(url: String,
                    params: [String: Any]?,
                    headers: [String: String]?,
                    success: @escaping ([String: Any]) -> Void,
                    fail: @escaping (String?) -> Void) {
        
        AF.request(url,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default,
                headers: self.transformHeaders(from: headers)
        ).responseJSON { (response) in
            //打印日志
            self.printAPI(url: url, params: params, headers: headers)
            
            switch response.result {
            case .success:
                if let value = response.value as? [String: Any] {
                    self.printResponse(value)
                    success(value)
                } else {
                    self.printResponse(nil)
                    fail("解析失败")
                }

            case .failure:
                printError(response.error)
                fail(response.error?.localizedDescription)
                break
            }
         }
     }
     
     /// POST请求
     /// - Parameters:
     ///   - url: 请求骶椎
     ///   - params: 参数
     ///   - headers: 请求头
     ///   - success: 成功回调
     ///   - fail: 失败回调
     public static func post(url: String,
                      params: [String: Any]?,
                      headers: [String: String]?,
                      success: @escaping ([String: Any]) -> Void,
                      fail: @escaping (String?) -> Void) {

          AF.request(url,
                     method: .post,
                     parameters: params,
                     encoding: URLEncoding.default,
                     headers: self.transformHeaders(from: headers)
          ).responseJSON { (response) in
            
            self.printAPI(url: url, params: params, headers: headers)
            switch response.result {
            case .success:
                if let value = response.value as? [String: Any] {
                    self.printResponse(value)
                    success(value)
                } else {
                    self.printResponse(nil)
                    fail("解析失败")
                }

            case .failure:
                printError(response.error)
                fail(response.error?.localizedDescription)
                break
            }
          }
      }

    
    /// DELETE请求
    /// - Parameters:
    ///   - url: 请求骶椎
    ///   - params: 参数
    ///   - headers: 请求头
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public static func delete(url: String,
                        params: [String: Any]?,
                        headers: [String: String]?,
                        success: @escaping ([String: Any]) -> Void,
                        fail: @escaping (String?) -> Void) {
         AF.request(url,
                    method: .delete,
                    parameters: params,
                    encoding: URLEncoding.default,
                    headers: self.transformHeaders(from: headers)
         ).responseJSON { (response) in
            self.printAPI(url: url, params: params, headers: headers)
            switch response.result {
            case .success:
                if let value = response.value as? [String: Any] {
                    self.printResponse(value)
                    success(value)
                } else {
                    self.printResponse(nil)
                    fail("解析失败")
                }

            case .failure:
                printError(response.error)
                fail(response.error?.localizedDescription)
                break
            }
         }
     }
    
    /// PUT请求
    /// - Parameters:
    ///   - url: 请求骶椎
    ///   - params: 参数
    ///   - headers: 请求头
    ///   - success: 成功回调
    ///   - fail: 失败回调
     public static func put(url: String,
                     params: [String: Any]?,
                     headers: [String: String]?,
                     success: @escaping ([String: Any]) -> Void,
                     fail: @escaping (String?) -> Void) {
          AF.request(url,
                     method: .put,
                     parameters: params,
                     encoding: URLEncoding.default,
                     headers: self.transformHeaders(from: headers)
          ).responseJSON { (response) in
              self.printAPI(url: url, params: params, headers: headers)
              switch response.result {
              case .success:
                  if let value = response.value as? [String: Any] {
                      self.printResponse(value)
                      success(value)
                  } else {
                      self.printResponse(nil)
                      fail("解析失败")
                  }

              case .failure:
                  printError(response.error)
                  fail(response.error?.localizedDescription)
                  break
              }
        }
      }
    
    /// POST JOSN请求
    /// - Parameters:
    ///   - url: 请求骶椎
    ///   - params: 参数
    ///   - headers: 请求头
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public static func post_json(url: String,
                           params: [String: Any]?,
                           headers: [String: String]?,
                           success: @escaping ([String: Any]) -> Void,
                           fail: @escaping (String?) -> Void) {

         AF.request(url,
                    method: .post,
                    parameters: params,
                    encoding: JSONEncoding.default,
                    headers: self.transformHeaders(from: headers)
         ).responseJSON { (response) in
            self.printAPI(url: url, params: params, headers: headers)
            switch response.result {
            case .success:
                if let value = response.value as? [String: Any] {
                    self.printResponse(value)
                    success(value)
                } else {
                    self.printResponse(nil)
                    fail("解析失败")
                }

            case .failure:
                printError(response.error)
                fail(response.error?.localizedDescription)
                break
            }
         }
     }

    /// PUT JOSN请求
    /// - Parameters:
    ///   - url: 请求骶椎
    ///   - params: 参数
    ///   - headers: 请求头
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public static func put_json(url: String,
                          params: [String: Any]?,
                          headers: [String: String]?,
                          success: @escaping ([String: Any]) -> Void,
                          fail: @escaping (String?) -> Void) {
         AF.request(url,
                    method: .put,
                    parameters: params,
                    encoding: JSONEncoding.default,
                    headers: self.transformHeaders(from: headers)
         ).responseJSON { (response) in
             self.printAPI(url: url, params: params, headers: headers)
             switch response.result {
             case .success:
                 if let value = response.value as? [String: Any] {
                     self.printResponse(value)
                     success(value)
                 } else {
                     self.printResponse(nil)
                     fail("解析失败")
                 }

             case .failure:
                 printError(response.error)
                 fail(response.error?.localizedDescription)
                 break
             }
         }
     }

    
    /// 上传图片
    /// - Parameters:
    ///   - url: 上传地址
    ///   - image: 图片
    ///   - name: 图片名字
    ///   - key: 字段
    ///   - headers: 请求头
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public static func upload(url: String,
                        image: UIImage,
                        name: String,
                        key: String,
                        headers: [String: String]?,
                        success: @escaping ([String: Any]) -> Void,
                        fail: @escaping (String?) -> Void) {
        
        AF.upload(multipartFormData: { (multipartFormData) in
            let data = image.jpegData(compressionQuality: 0.5)
            multipartFormData.append(data!, withName: key, fileName: name, mimeType: "image/jpeg")
        }, to: url,
           method: .post,
           headers: self.transformHeaders(from: headers)
        ).responseJSON { (response) in
            self.printAPI(url: url, headers: headers)
            switch response.result {
            case .success:
                if let value = response.value as? [String: Any] {
                    self.printResponse(value)
                    success(value)
                } else {
                    self.printResponse(nil)
                    fail("解析失败")
                }

            case .failure:
                printError(response.error)
                fail(response.error?.localizedDescription)
                break
            }
        }
     }
}
