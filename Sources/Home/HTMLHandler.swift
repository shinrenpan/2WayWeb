//
//  HTMLHandler.swift
//
//  Created by Joe Pan on 2024/10/12.
//
//

import WebKit

final class HTMLHandler: NSObject {
    enum JSFunction: String, CaseIterable {
        case askNamePermission
        case askAgePermission
    }
    
    var jsCallback: ((JSFunction) -> Void)?
}

// MARK: - WKScriptMessageHandler

extension HTMLHandler: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let jsFunction = JSFunction(rawValue: message.name) else {
            return
        }
        
        jsCallback?(jsFunction)
    }
}
