//
//  UseDeskSDK.swift

import Foundation
import SocketIO
import UserNotifications

public class UseDeskSDK: NSObject {
    @objc public var newMessageBlock: UDMessageBlock?
    @objc public var connectBlock: UDConnectBlock?
    @objc public var feedbackMessageBlock: UDFeedbackMessageBlock?
    @objc public var feedbackAnswerMessageBlock: UDFeedbackAnswerMessageBlock?
    @objc public var presentationCompletionBlock: UDVoidBlock?
    @objc public var historyMess: [UDMessage] = []
    @objc public var maxCountAssets: Int = 10
    @objc public var isSupportedAttachmentOnlyPhoto: Bool = false
    @objc public var isSupportedAttachmentOnlyVideo: Bool = false
    // UDCallbackSettings
    public var callbackSettings = UDCallbackSettings()
    // Socket
    var manager: SocketManager?
    var socket: SocketIOClient?
    // closure StartBlock
    var closureStartBlock: UDStartBlock? = nil
    var closureErrorBlock: UDErrorBlock? = nil
    // Storage
    var storage: UDStorage? = nil
    var isCacheMessagesWithFile: Bool = true
    // Configutation
    var model = UseDeskModel() {
        didSet {
            networkManager?.model = model
        }
    }
    var icConnecting: Bool = false
    // Network
    var networkManager: UDNetworkManager? = nil
    
    // MARK: - Start Methods
    
    @objc public func start(companyID: String, chanelId: String, url: String, port: String? = nil, urlAPI: String? = nil, api_token: String? = nil, urlToSendFile: String? = nil, knowledgeBaseID: String? = nil, name: String? = nil, email: String? = nil, phone: String? = nil, avatar: Data? = nil, token: String? = nil, additional_id: String? = nil, note: String? = nil, additionalFields: [Int : String] = [:], additionalNestedFields: [[Int : String]] = [], firstMessage: String? = nil, countMessagesOnInit: NSNumber? = nil, localeIdentifier: String? = nil, customLocale: [String : String]? = nil, isSaveTokensInUserDefaults: Bool = true, connectionStatus startBlock: @escaping UDStartBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        
        closureStartBlock = startBlock
        closureErrorBlock = errorBlock
        
        UDValidationManager.validateInitionalsFields(companyID: companyID, chanelId: chanelId, url: url, port: port, urlAPI: urlAPI, api_token: api_token, urlToSendFile: urlToSendFile, knowledgeBaseID: knowledgeBaseID, name: name, email: email, phone: phone, avatar: avatar, token: token, additional_id: additional_id, note: note, additionalFields: additionalFields, additionalNestedFields: additionalNestedFields, firstMessage: firstMessage, countMessagesOnInit: countMessagesOnInit, localeIdentifier: localeIdentifier, customLocale: customLocale, isSaveTokensInUserDefaults: isSaveTokensInUserDefaults, validModelBlock: { [weak self] validModel in
            self?.model = validModel
            self?.start(startBlock: startBlock, errorBlock: errorBlock)
        }, errorStatus: errorBlock)
    }
    
    // MARK: - Public Methods
    @objc public func sendAvatarClient(connectBlock: @escaping UDConnectBlock, errorBlock: @escaping UDErrorBlock) {
        networkManager?.sendAvatarClient(connectBlock: connectBlock, errorBlock: errorBlock)
    }
    
    @objc public func getMessages(idComment: Int, newMessagesBlock: @escaping UDNewMessagesBlock, errorBlock: @escaping UDErrorBlock) {
        networkManager?.getMessages(idComment: idComment, newMessagesBlock: newMessagesBlock, errorBlock: errorBlock)
    }
    
    @objc public func sendMessage(_ text: String, messageId: String? = nil, completionBlock: UDVoidBlock? = nil) {
        let mess = UseDeskSDKHelp.messageText(text, messageId: messageId)
        socket?.connect()
        socket?.emit("dispatch", mess!, completion: completionBlock)
    }
    
    @objc public func sendFile(fileName: String, data: Data, messageId: String? = nil, progressBlock: UDProgressUploadBlock? = nil, connectBlock: UDConnectBlock? = nil, errorBlock: UDErrorBlock? = nil) {
        let url = model.urlToSendFile != "" ? model.urlToSendFile : "https://secure.usedesk.ru/uapi/v1/send_file"
        networkManager?.sendFile(url: url, fileName: fileName, data: data, messageId: messageId, progressBlock: progressBlock, connectBlock: connectBlock, errorBlock: errorBlock)
    }
    
    @objc public func getCollections(connectionStatus baseBlock: @escaping UDBaseBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        networkManager?.getCollections(baseBlock: baseBlock, errorBlock: errorBlock)
    }
    
    @objc public func getArticle(articleID: Int, connectionStatus baseBlock: @escaping UDArticleBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        networkManager?.getArticle(articleID: articleID, baseBlock: baseBlock, errorBlock: errorBlock)
    }
    
    @objc public func addViewsArticle(articleID: Int, count: Int, connectionStatus connectBlock: @escaping UDConnectBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        networkManager?.addViewsArticle(articleID: articleID, count: count, connectBlock: connectBlock, errorBlock: errorBlock)
    }
    
    @objc public func addReviewArticle(articleID: Int, countPositive: Int = 0, countNegative: Int = 0, connectionStatus connectBlock: @escaping UDConnectBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        networkManager?.addReviewArticle(articleID: articleID, countPositive: countPositive, countNegative: countNegative, connectBlock: connectBlock, errorBlock: errorBlock)
    }
    
    @objc public func sendReviewArticleMesssage(articleID: Int, message: String, connectionStatus connectBlock: @escaping UDConnectBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        networkManager?.sendReviewArticleMesssage(articleID: articleID, subject: model.stringFor("ArticleReviewForSubject"), message: message, tag: model.stringFor("KnowlengeBaseTag"), email: model.email, phone: model.phone, name: model.name, connectionStatus: connectBlock, errorStatus:errorBlock)
    }
    
    @objc public func getSearchArticles(collection_ids:[Int], category_ids:[Int], article_ids:[Int], count: Int = 20, page: Int = 1, query: String, type: TypeArticle = .all, sort: SortArticle = .id, order: OrderArticle = .asc, connectionStatus searchBlock: @escaping UDArticleSearchBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        networkManager?.getSearchArticles(collection_ids: collection_ids, category_ids: category_ids, article_ids: article_ids, count: count, page: page, query: query, type: type, sort: sort, order: order, searchBlock: searchBlock, errorBlock: errorBlock)
    }
    
    func sendOfflineForm(name nameClient: String?, email emailClient: String?, message: String, file: UDFile? = nil, topic: String? = nil, fields: [UDCallbackCustomField]? = nil, callback resultBlock: @escaping UDConnectBlock, errorStatus errorBlock: @escaping UDErrorBlock) {
        networkManager?.sendOfflineForm(companyID: model.companyID, chanelID: model.chanelId, name: nameClient ?? model.name, email: emailClient ?? model.email, message: message, file: file, topic: topic, fields: fields, connectBlock: resultBlock, errorBlock: errorBlock)
    }
    
    @objc public func sendMessageFeedBack(_ status: Bool, message_id: Int) {
        socket?.emit("dispatch", UseDeskSDKHelp.feedback(status, message_id: message_id)!, completion: nil)
    }
    
    @objc public func closeChat() {
        socket?.disconnect()
        historyMess = []
    }
    
    @objc public func releaseChat() {
        networkManager = nil
        socket?.disconnect()
        manager?.disconnect()
        socket = nil
        manager = nil
        historyMess = []
        model = UseDeskModel()
        presentationCompletionBlock?()
    }
    
    // MARK: - Ppivate Methods
    private func start(startBlock: @escaping UDStartBlock, errorBlock: @escaping UDErrorBlock) {
        let urlAdress = URL(string: model.url)
        guard urlAdress != nil else {
            errorBlock(.urlError, UDError.urlError.description)
            return
        }
        
        var isNeedLogSocket = false
        #if DEBUG
            isNeedLogSocket = true
        #endif
        manager = SocketManager(socketURL: urlAdress!, config: [.log(isNeedLogSocket),
                                                                .version(.three),
                                                                .reconnects(true),
                                                                .reconnectWaitMax(1),
                                                                .reconnectWait(0),
                                                                .forceWebsockets(true)])
        socket = manager?.defaultSocket

        if networkManager == nil {
            networkManager = UDNetworkManager(model: model)
        }
        networkManager?.usedesk = self
        networkManager?.model = model
        networkManager?.socket = socket
        
        networkManager?.socketConnect(socket: socket, connectBlock: connectBlock)
        networkManager?.socketError(socket: socket, errorBlock: errorBlock)
        networkManager?.socketDisconnect(socket: socket, connectBlock: connectBlock)
        networkManager?.socketDispatch(socket: socket, startBlock: { [weak self] success, feedbackStatus, token in
            startBlock(success, feedbackStatus, token)
            self?.connectBlock?(true)
        }, historyMessagesBlock: { [weak self] messages in
            self?.historyMess = messages
        }, callbackSettingsBlock: { [weak self] callbackSettings in
            self?.callbackSettings = callbackSettings
        }, newMessageBlock: { [weak self] message in
            self?.newMessageBlock?(message)
        }, feedbackMessageBlock: { [weak self] message in
            self?.feedbackMessageBlock?(message)
        }, feedbackAnswerMessageBlock: { [weak self] bool in
            self?.feedbackAnswerMessageBlock?(bool)
        })
    }
}
