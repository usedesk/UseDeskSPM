//
//  UDValidationManager.swift

import Foundation

public class UDValidationManager {
    
    class func validateInitionalsFields(companyID: String? = nil, chanelId: String? = nil, url: String? = nil, port: String? = nil, urlAPI: String? = nil, api_token: String? = nil, urlToSendFile: String? = nil, knowledgeBaseID: String? = nil, name: String? = nil, email: String? = nil, phone: String? = nil, avatar: Data? = nil, avatarUrl: URL? = nil, token: String? = nil, additional_id: String? = nil, note: String? = nil, additionalFields: [Int : String] = [:], additionalNestedFields: [[Int : String]] = [], nameOperator: String? = nil, firstMessage: String? = nil, countMessagesOnInit: NSNumber? = nil, localeIdentifier: String? = nil, customLocale: [String : String]? = nil, isSaveTokensInUserDefaults: Bool = true, validModelBlock: @escaping UDValidModelBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
       
        var model = UseDeskModel()
        
        model.additionalFields = additionalFields
        model.additionalNestedFields = additionalNestedFields
        
        if companyID != nil {
            model.companyID = companyID!
        }
        
        if chanelId != nil {
            guard chanelId!.trimmingCharacters(in: .whitespaces).count > 0 && Int(chanelId!) != nil else {
                errorBlock(.chanelIdError, UDError.chanelIdError.description)
                return
            }
            model.chanelId = chanelId!
        }
        
        model.knowledgeBaseID = knowledgeBaseID ?? ""
        
        if api_token != nil {
            model.api_token = api_token!
        }
        
        if port != nil {
            if port != "" {
                model.port = port!
            }
        }
        
        if url != nil {
            guard isValidSite(path: url!) else {
                errorBlock(.urlError, UDError.urlError.description)
                return
            }
            model.urlWithoutPort = url!
            
            if isExistProtocol(url: url!) {
                model.url = "\(url!):\(model.port)"
            } else {
                model.url = "https://" + "\(url!):\(model.port)"
            }
        }
        
        if email != nil {
            if email != "" {
                if email!.udIsValidEmail() {
                    model.email = email!
                } else {
                    errorBlock(.emailError, UDError.emailError.description)
                    return
                }
            }
        }
        
        if urlToSendFile != nil {
            if urlToSendFile != "" {
                guard isValidSite(path: urlToSendFile!) else {
                    errorBlock(.urlToSendFileError, UDError.urlToSendFileError.description)
                    return
                }
                if isExistProtocol(url: urlToSendFile!) {
                    model.urlToSendFile = urlToSendFile!
                } else {
                    model.urlToSendFile = "https://" + urlToSendFile!
                }
            }
        }
        
        if urlAPI != nil {
            if urlAPI != "" {
                var urlAPIValue = urlAPI!
                if !isExistProtocol(url: urlAPIValue) {
                    urlAPIValue = "https://" + urlAPIValue
                }
                guard isValidSite(path: urlAPIValue) else {
                    errorBlock(.urlAPIError, UDError.urlAPIError.description)
                    return
                }
                model.urlAPI = urlAPIValue
            }
        }
        
        if name != nil {
            if name != "" {
                model.name = name!
            }
        }
        
        if avatar != nil {
            model.avatar = avatar!
        } else if avatarUrl != nil {
            model.avatarUrl = avatarUrl!
        }
        
        if nameOperator != nil {
            if nameOperator != "" {
                model.nameOperator = nameOperator!
            }
        }
        
        if phone != nil {
            if phone != "" {
                guard isValidPhone(phone: phone!) else {
                    errorBlock(.phoneError, UDError.phoneError.description)
                    return
                }
                model.phone = phone!
            }
        }
        
        if firstMessage != nil {
            if firstMessage != "" {
                model.firstMessage = firstMessage!
            }
        }
        
        if countMessagesOnInit != nil {
            guard Int(truncating: countMessagesOnInit!) >= 10 else {
                errorBlock(.countMessagesOnInitError, UDError.countMessagesOnInitError.description)
                return
            }
            model.countMessagesOnInit = Int(truncating: countMessagesOnInit!)
        } else {
            model.countMessagesOnInit = UD_LIMIT_PAGINATION_DEFAULT
        }
        
        if note != nil {
            if note != "" {
                model.note = note!
            }
        }
        
        if additional_id != nil {
            if additional_id != "" {
                model.additional_id = additional_id!
            }
        }
        
        if token != nil {
            if token != "" {
                if !token!.udIsValidToken() {
                    errorBlock(.tokenError, UDError.tokenError.description)
                    return
                }
                model.token = token!
            }
        }
        
        model.isSaveTokensInUserDefaults = isSaveTokensInUserDefaults
        validModelBlock(model)
    }
    
    class func isValidApiParameters(model: UseDeskModel, errorBlock: @escaping UDErrorBlock) -> Bool {
        if model.knowledgeBaseID == "" {
            errorBlock(.emptyKnowledgeBaseID, UDError.emptyKnowledgeBaseID.description)
            return false
        }
        if model.api_token == "" {
            errorBlock(.emptyTokenAPI, UDError.emptyTokenAPI.description)
            return false
        }
        return true
    }
    
    // MARK: - Private Methods
    private class func isValidSite(path: String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: path)
    }
    
    private class func isValidPhone(phone:String) -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: phone, options: [], range: NSMakeRange(0, phone.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == phone.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    private class func isExistProtocol(url: String) -> Bool {
        if url.count > 8 {
            let indexEndHttps = url.index(url.startIndex, offsetBy: 7)
            let indexEndHttp = url.index(url.startIndex, offsetBy: 6)
            if url[url.startIndex...indexEndHttps] != "https://" && url[url.startIndex...indexEndHttp] != "http://" {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
}
