//
//  WebService.swift
//  Scoozme
//
//  Created by Omara on 27.07.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class WebService {
    
    class func downloadImage(withURL imageUrl: String,
                             callBack:@escaping (UIImage?) -> Void,
                             failureHandler:@escaping (Error) -> Void) {
        let remoteImageURL = URL(string: imageUrl)!
        Alamofire.request(remoteImageURL).responseData { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    callBack(UIImage(data: data))
                }
            case .failure(let error):
                failureHandler(error)
            }
        }
    }
    
    class func request<T: BaseMappable>(urlString: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, reTryCount:Int,
                    callBack:@escaping (T) -> Void,
                    failureHandler:@escaping (Error) -> Void) {
        
        
        Alamofire.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseObject { (response: DataResponse<T>) in
            switch response.result {
            case .success:
                if let result = response.result.value{
                    callBack(result)
                }
            case .failure(let error):
              
                reTryCount == 0 ? failureHandler(error) : request(urlString: urlString, method: method, parameters: parameters, headers: headers, reTryCount: reTryCount - 1, callBack: callBack, failureHandler: failureHandler)
                
            }

            }
        
    }
    
    class func requestMultiPart<T: BaseMappable>(urlString: String, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders?, reTryCount:Int,
                                        callBack:@escaping (T) -> Void,
                                        failureHandler:@escaping (Error) -> Void) {
        
        Alamofire.upload(multipartFormData: { (multiPartData) in
            
            if let image = parameters["avatar"] as? UIImage {
                let imgData = image.jpegData(compressionQuality: 0.2)
                multiPartData.append(imgData!, withName: "avatar", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
            if let bussinessCardImage = parameters["business_card"] as? UIImage {
                let imgData = bussinessCardImage.jpegData(compressionQuality: 0.2)
                multiPartData.append(imgData!, withName: "business_card", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
            if let eventImage = parameters["image"] as? UIImage {
                let imgData = eventImage.jpegData(compressionQuality: 0.2)
                multiPartData.append(imgData!, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
//            if videoUrl != nil {
//
//                var videoData : Data!
//                do {
//                    try videoData = Data(contentsOf: videoUrl!)
//                    multiPartData.append(videoData, withName: videoName, fileName: "video.mp4", mimeType: "video/mp4")
//
//                } catch {
//
//                    print("error while read video")
//                }
//            }
            
            for (key, value) in parameters {
                if key == "avatar" || key == "business_card" || key == "image" {
                    continue
                }
                multiPartData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, usingThreshold: 0, to: urlString, method: method, headers: headers) { (sessionManager) in
            switch sessionManager {
            case .success(let upload, _ , _ ):
                upload.responseObject { (response: DataResponse<T>) in
                    switch response.result {
                    case .success:
                        if let result = response.result.value{
                            callBack(result)
                        }
                    case .failure(let error):
                        failureHandler(error)
                    }
                }
            case .failure(let error):
                reTryCount == 0 ? failureHandler(error) : requestMultiPart(urlString: urlString, method: method, parameters: parameters, headers: headers, reTryCount: reTryCount - 1, callBack: callBack, failureHandler: failureHandler)

            }
        }
    }
}
