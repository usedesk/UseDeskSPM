//
//  UDConfiguration.swift
//  UseDesk_SDK_Swift
//
//

import Alamofire
import Foundation

let UD_TYPE_TEXT = 1
let UD_TYPE_EMOJI = 2
let UD_TYPE_PICTURE = 3
let UD_TYPE_VIDEO = 4
let UD_TYPE_File = 5
let UD_TYPE_Feedback = 6

let UD_STATUS_LOADING = 1
let UD_STATUS_SUCCEED = 2
let UD_STATUS_OPENIMAGE = 3

let UD_STATUS_SEND_FAIL = 1
let UD_STATUS_SEND_DRAFT = 2
let UD_STATUS_SEND_SUCCEED = 3

let UD_AUDIOSTATUS_STOPPED = 1
let UD_AUDIOSTATUS_PLAYING = 2

public typealias UDStartBlock = (Bool, UDFeedbackStatus, String) -> Void
public typealias UDBaseBlock = (Bool, [UDBaseCollection]?) -> Void
public typealias UDArticleBlock = (Bool, UDArticle?) -> Void
public typealias UDArticleSearchBlock = (Bool, UDSearchArticle?) -> Void
public typealias UDConnectBlock = (Bool) -> Void
public typealias UDNewMessageBlock = (UDMessage?) -> Void
public typealias UDNewMessagesBlock = ([UDMessage]) -> Void
public typealias UDErrorBlock = (UDError, String?) -> Void
public typealias UDFeedbackMessageBlock = (UDMessage?) -> Void
public typealias UDFeedbackAnswerMessageBlock = (Bool) -> Void
public typealias UDVoidBlock = () -> Void
public typealias UDProgressUploadBlock = (Progress) -> Void
public typealias UDValidModelBlock = (UseDeskModel) -> Void

@objc public enum UDFeedbackStatus: Int {
    case null
    case never
    case feedbackForm
    case feedbackFormAndChat
    
    var isNotOpenFeedbackForm: Bool {
        return self == .null || self == .never
    }
    
    var isOpenFeedbackForm: Bool {
        return self == .feedbackForm || self == .feedbackFormAndChat
    }
}

@objc public protocol UDStorage {
    func getMessages() -> [UDMessage]
    func saveMessages(_ messages: [UDMessage])
}

public struct UseDeskModel {
    var companyID = ""
    var chanelId = ""
    var email = ""
    var phone = ""
    var url = ""
    var urlToSendFile = ""
    var urlWithoutPort = ""
    var urlAPI = ""
    var knowledgeBaseID = ""
    var baseSections: [UDBaseCollection] = []
    var api_token = ""
    var port = ""
    var name = ""
    var avatar: Data? = nil
    var nameOperator = ""
    var nameChat = ""
    var firstMessage = ""
    var note = ""
    var token = ""
    var additional_id = ""
    var localeIdentifier = ""
    var additionalFields: [Int : String] = [:]
    var additionalNestedFields: [[Int : String]] = []
    var idLoadingMessages: [String] = []
    var isSaveTokensInUserDefaults = true
    // Lolace
    var locale: [String:String] = [:]
    
    func stringFor(_ key: String) -> String {
        if let word = locale[key] {
            return word
        } else {
            return key
        }
    }
    
    func isEmpty() -> Bool {
        return companyID == ""
    }
}
