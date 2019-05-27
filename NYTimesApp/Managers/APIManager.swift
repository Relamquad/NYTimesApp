//
//  APIManager.swift
//  NYTimesApp
//
//  Created by Konstantin Kalivod on 5/23/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import Foundation
import Alamofire
class APIManager{
    class func getWeatherInfoIn(type: String, completion: @escaping ([Article]) -> ()){
        var myArticles : [Article] = []
        let baseURL = "https://api.nytimes.com/svc/mostpopular/v2/\(type)/30.json?api-key=95d3mGqpDdAm7FnQPAYWO6PbrriiBLU0"
        Alamofire.request(baseURL).responseJSON { response in
            
            guard response.result.isSuccess else {
                print("Ошибка при запросе данных \n\n\(String(describing: response.result.error))")
                return
            }
            if let JSON = response.result.value as? Dictionary<String, AnyObject> {
                //Получаем json и массив с новостями + проверка
                let results = JSON["results"] as?  [Dictionary<String, Any>]
                print("JSON == \(String(describing: results))")
                
                //Заполнение массива
                var returnArray: [Article] = []
                for dict in results ?? [] {
                    let newArticle = Article(dictionary: dict)
                    returnArray.append(newArticle)
                }
                myArticles = returnArray
    }
            completion(myArticles)
        }
}
}
