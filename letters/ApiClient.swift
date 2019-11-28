
//  ApiClient.swift
//  letters
//
//  Created by Mati on 27/11/2019.
//  Copyright © 2019 devmini. All rights reserved.


import Foundation
import Alamofire

class ApiClient {

    func checkWord(word:String,completion:@escaping (_ result:Bool) -> Void) {
        //completion es una función que voy a llamar una vez haga la request
        // word = palabra a comprobar
        //    method: get
        //    token: "Bearer uHS_7Q2Esg7XsUKNsaqFx2sB1mca"
        
        let url = "https://store.apicultur.com/api/corrige-palabra/1.0.0/" + word
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer uHS_7Q2Esg7XsUKNsaqFx2sB1mca",
            "Accept": "application/json"
        ]
        
        AF.request(url,headers: headers).responseJSON { response in
            
            print(response.response) // http url response
            print(response.result)  // response serialization result
            
//            if let data = response.data {
//                let desc = data.description
//                completion(desc)
//
//            } else {
//                completion("")
//            }
            
            // si la palabra es correcta, no hay description
 
             //cambiar result a String en vez de Bool en la definición de la función si optamos por mostrar la respuesta como el trozo de código arriba comentado
            
            
            switch(response.result) {
            case .success(let response):
                let arrayResponse = response as! NSArray
                
                if(arrayResponse.count > 0) {
                    let parsed = arrayResponse[0] as! NSDictionary
                    
                    print(parsed["palabra_error"])
                    completion(false)
                    
                } else {
                    print("Palabra correcta")
                    completion(true)
                }
                
            case .failure:
                print("ERROR REQUEST")
            }
        }
    }
}
