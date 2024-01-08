//
//  PrivacyInfo.swift
//  MovieApp
//
//  Created by Vanopr on 03.01.2024.
//

import Foundation

struct PrivacyInfo {
    
    // MARK: - Private Properties
    private let aboutUs =
"""
Welcome to MovieApp, your premier destination for an unparalleled cinematic experience. MovieApp is committed to safeguarding your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, and protect your data. By using MovieApp, you agree to the terms outlined in this policy.
""".localized
    private let informationWeCollect =
     """
Account Information: To enhance your experience, we collect registration details, including your name, email, and profile information.
Usage Information: We gather data on your interactions with MovieApp, such as viewing history and preferences.
Device Information: Information about your device, operating system, and unique identifiers may be collected.
""".localized
    private let  howWeUseYourInformation =
     """
We use the collected data to provide, personalize, and improve MovieApp services.
Information is processed for transactions, customer support, and to analyze usage patterns for feature enhancement.
""".localized
    
    private let security =
"""
Industry-standard measures are implemented to protect your information from unauthorized access, alteration, or disclosure.
""".localized
    private let childrensPrivacy =
"""
MovieApp is not intended for users under 13, and we do not knowingly collect information from children.
""".localized
    
    private let contactUs =
    """
If you have any questions or concerns about this Privacy Policy, please contact us at [https://github.com/Vanopr].
""".localized
    
    private let thankYou = """
Thank you for choosing MovieApp. We are committed to providing you with an exceptional and secure movie-watching experience.
""".localized
  
     func getSectionsInfo() -> [PrivacyInfoModel] {
         let about = PrivacyInfoModel(title: "About Us".localized, description: aboutUs)
         let info =  PrivacyInfoModel(title: "Information we collect".localized, description: informationWeCollect)
         let howWeUse = PrivacyInfoModel(title: "How we use your information".localized, description: howWeUseYourInformation)
         let security = PrivacyInfoModel(title: "Security".localized, description: security)
         let childrensPrivacy = PrivacyInfoModel(title: "Children's privacy".localized, description: childrensPrivacy)
         let contactUs = PrivacyInfoModel(title: "Contact us".localized, description: contactUs)
         let thankYou = PrivacyInfoModel(title: "Thank you".localized, description: thankYou)
         return [about, info, howWeUse, security, childrensPrivacy, contactUs, thankYou]
    }

}
