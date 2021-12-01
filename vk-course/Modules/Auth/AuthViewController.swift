//
//  AuthViewController.swift
//  vk-course
//
//  Created by Artur Igberdin on 01.12.2021.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeToVKAPI()
    }
    
    func authorizeToVKAPI() {
        
        //Конструктор URL безопасный - UTF 8
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"), //Число то что мы запрашиваем permissions
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        //Запрос
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request) //OAuth
        
    }
    
    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html"
        else {
            decisionHandler(.allow) //При обнаружении страницы html - страница авторизации
            return
        }
        
        //https://oauth.vk.com/authorize?client_id=7822904&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=262150&response_type=token&revoke=1&v=5.68
        
        //https://oauth.vk.com/blank.html#access_token=4c6103ffb00932937bc12408ac00960864a830b4626c264112c5eacc0856bc21d6de2a1be276ff90a252b&expires_in=86400&user_id=223761261
        
        /*
         
         url.fragment
         
         access_token=4c6103ffb00932937bc12408ac00960864a830b4626c264112c5eacc0856bc21d6de2a1be276ff90a252b&expires_in=86400&user_id=223761261
         
         [access_token=4c6103ffb00932937bc12408ac00960864a830b4626c264112c5eacc0856bc21d6de2a1be276ff90a252b, expires_in=86400, user_id=223761261]
         
         user_id=223761261 - [user_id, 223761261] -> dict
         
         */
        
        let params = url.fragment?
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String](), { result, param in
                
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            })
            
        guard let token = params?["access_token"], let userId = params?["user_id"] else { return }
        
        //TODO: - Сохранение в Синглтон
        
        //TODO: - Навигация впреед в экран Друзья
        
        print(url)
        
        decisionHandler(.cancel)
    }
}

//Синглтон - ОЗУ - пока существует приложение
final class Session {
    private init() {}
    
    static var shared = Session()
    
    var token = ""
    var userId = ""
}
