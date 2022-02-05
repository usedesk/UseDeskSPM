//
//  UDLocalizeManager.swift
//  UseDesk_SDK_Swift


import Foundation

class UDLocalizeManager {
    var languages: [String : Any] = [:]
    
    private var enLocale: [String:String] = [:]
    private var ruLocale: [String:String] = [:]
    private var ptLocale: [String:String] = [:]
    private var esLocale: [String:String] = [:]
    
    init() {
        enLocale = getEnLocale()
        ruLocale = getRuLocale()
        ptLocale = getPtLocale()
        esLocale = getEsLocale()
        languages = [
            "en" : enLocale,
            "ru" : ruLocale,
            "pt" : ptLocale,
            "es" : esLocale
        ]
    }
    
    func getLocaleFor(localeId: String) -> [String:String]? {
        if let locale = languages[localeId] as? [String:String] {
            return locale
        } else {
            if localeId.count >= 2 {
                let shorhLocaleId: String = String(localeId[localeId.startIndex..<localeId.index(localeId.startIndex, offsetBy: 2)])
                if let locale = languages[shorhLocaleId] as? [String:String] {
                    return locale
                }
            }
            return nil
        }
    }
    
    // MARK: - Russia
    private func getRuLocale() -> [String:String] {
        let ruLocale: [String:String] = [
            "ArticleReviewForSubject"  : "Отзыв о статье",
            "KnowlengeBaseTag"         : "БЗ",
            "CSIReviewLike"            : "Оценка: отлично",
            "CSIReviewDislike"         : "Оценка: плохо"
        ]
        return ruLocale
    }
    
    // MARK: - English
    private func getEnLocale() -> [String:String] {
        let enLocale: [String:String] = [
            "ArticleReviewForSubject"  : "Article review",
            "KnowlengeBaseTag"         : "Knowlenge Base",
            "CSIReviewLike"            : "Rating: excellent",
            "CSIReviewDislike"         : "Rating: poor"
        ]
        return enLocale
    }
    
    // MARK: - Spanish
    private func getEsLocale() -> [String:String] {
        let esLocale: [String:String] = [
            "ArticleReviewForSubject"  : "Revisión del artículo",
            "KnowlengeBaseTag"         : "Base de conocimiento",
            "CSIReviewLike"            : "Satisfacción: Excelente",
            "CSIReviewDislike"         : "Satisfacción: Pobre"
        ]
        return esLocale
    }
    
    // MARK: - Portugal
    private func getPtLocale() -> [String:String] {
        let ptLocale: [String:String] = [
            "ArticleReviewForSubject"  : "Avaliação do artigo",
            "KnowlengeBaseTag"         : "Base de Conhecimento",
            "CSIReviewLike"            : "Avaliação: Excelente",
            "CSIReviewDislike"         : "Avaliação: Ruim"
        ]
        return ptLocale
    }
    
    
}
