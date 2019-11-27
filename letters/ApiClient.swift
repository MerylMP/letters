//
//  ApiClient.swift
//  letters
//
//  Created by Mati on 27/11/2019.
//  Copyright © 2019 devmini. All rights reserved.
//

//import Foundation
//import Alamofire
//
//class ApiClient {
//
//    func checkWord(word:String,completion:@escaping (_ result:String) -> Void) {
//        //completion es una función que voy a llamar una vez haga la request
//
//        var url = "https://store.apicultur.com/api/corrige-palabra/1.0.0/" + word
//
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer uHS_7Q2Esg7XsUKNsaqFx2sB1mca",
//            "Accept": "application/json"
//        ]
//
//        AF.request(url,headers: headers).responseJSON { response in
//
//            if let data = response.data {
//                let desc = data.description
//                completion(desc)
//
//            } else {
//                completion("")
//            }
//
//            // si la palabra es correcta, no hay description
//
//
//        }
//    }
//
//    //==================================
////    url: https://store.apicultur.com/api/corrige-palabra/1.0.0/<palabara_a_comprobar>
////    method: get
////    token: "Bearer uHS_7Q2Esg7XsUKNsaqFx2sB1mca"
////
////
////
////    /* CODE TI¿O REQUEST TO THE API */
////
////     var url = "https://store.apicultur.com/api/corrige-palabra/1.0.0/<palabra>"
////
////          let headers: HTTPHeaders = [
////            "Authorization": "Bearer uHS_7Q2Esg7XsUKNsaqFx2sB1mca",
////            "Accept": "application/json"
////          ]
////
////          AF.request(url,headers: headers).responseJSON { response in
////
////              //print(response.response) // http url response
////              print(response.result)  // response serialization result
////
////          }
    
//}
