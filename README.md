# UseDeskSPM
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

## This manual in other languages

Also available in [Russian](README_RU.md)

# Adding a library to the project

### Swift Package Manager

```swift
.package(url: "https://github.com/usedesk/UseDeskSPM.git", from: "1.2.0")
```

## Initializing SDK 

### Parameters used in the configuration SDK

Where * — required parameter

| **Parameter** | **Type** | **Description** |
| --- | --- | --- |
| **CompanyID*** | String |**Company ID in Usedesk**<br/>[How to find a company ID](https://en.usedocs.com/article/6396)  |
| **ChannelID*** | String | **ID of the chat channel through which messages from the application will be placed at Usedesk**<br/>[How to create and set up a channel](https://en.usedocs.com/article/16616)  |
| **Url*** | String | **Server URL for SDK chats**<br/>By default: `pubsubsec.usedesk.ru`<br/>If you use server version of Usedesk on your own server, value may be different for you. Check with our team for valid URL — support@usedesk.com  |
| **Port** | String | **Server port for SDK chats**<br/>By default: `443` |
| **UrlAPI*** | String | **URL to work with Usedesk API**<br/>By default: `secure.usedesk.ru/uapi`<br/>If you use server version of Usedesk on your own server, value may be different for you. Check with our team for valid URL — support@usedesk.com |
| **API_token** | String | **Usedesk API Token**<br/>[How to get API Token](https://en.usedocs.com/article/10169) |
| **KnowledgeBaseID** | String |  **Knowledge Base ID**<br/>[How to create a Knowledge Base](https://en.usedocs.com/article/7182)<br/>**If ID is not provided, Knowledge Base will not be used**|
| **UrlToSendFile** | String | **URL for sending files**<br/>By default: `https://secure.usedesk.ru/uapi/v1/send_file` |
| **Name** | String | **Client name** |
| **Email** | String | **Client email** |
| **Phone** | String | **Client phone** |
| **Avatar** | Data? | **Client avatar** |
| **Token** | String | **A unique token that uniquely identifies the user and his conversation**<br/>The token is provided in the callback after the initialization of the chat and is linked to the mail-phone-user name.<br/>To identify different users on the same device, you must store and pass the received token to the initialization method |
| **AdditionalId** | String | **Additional customer ID** |
| **Note** | String | **Text of note** |
| **AdditionalFields** | Int : String | **Array of ticket additional fields**<br/>Format: `id : "value"`<br/>For text fields the value is a string, for a list the value is a string with the exact list value, for a flag the value is a string `false` or `true` |
| **AdditionalNestedFields** | Int : String | **Array of additional fields of nested list type**<br/>Each subarray represents one nested list. <br/>Format of nested list: `[id1: "value", id2 : "value", id3 : "value"]`, where `id1`, `id2`, `id3` — value identifiers by nesting levels |
| **FirstMessage** | String | **Automatic message**<br/>Sent immediately after initialization on behalf of the client |
| **CountMessagesOnInit** | Int | **Number of loaded messages when starting the chat**<br/>When client open a chat, a specified number of messages are loaded. As client scrolls chat, 20 more messages are loaded |
| **LocaleIdentifier** | String | **Language Identifier**<br/>Available languages: Russian (`ru`), English (`en`), Portugiese (`pt`), Spanish (`es`). <br/>If passed identifier is not supported, the Russian language will be used |
| **CustomLocale** | String : String | **Your own translation dictionary**<br/>If the SDK needs to be displayed in a language we do not support, you can create a translation dictionary yourself and use it |
| **isSaveTokensInUserDefaults** | Bool | **The flag of automatic display of the controller in the specified parent controller**<br/>By default: `true`  |


### SDK Initializing

```swift
let usedesk = UseDeskSDK()
usedesk.start(
    companyID: "1234567",
    chanelId: "1234", 
    url: "pubsubsec.usedesk.ru", 
    port: "443",
    urlAPI: "pubsubsec.usedesk.ru", 
    api_token: "143ed59g90ef093s",
    urlToSendFile: "https://secure.usedesk.ru/uapi/v1/send_file", 
    knowledgeBaseID: "12",
    name: "Name", 
    email: "lolo@yandex.ru", 
    phone: "89000000000", 
    avatar: avatarData,
    token: "Token", 
    additional_id: "additional_id",
    note: "Note text", 
    additionalFields: [1 : "value"], 
    additionalNestedFields: [[1 : "value1", 2 : "value2", 3 : "value3"]], 
    firstMessage: "message",
    сountMessagesOnInit: 30,
    localeIdentifier: "en", 
    customLocale: customLocaleDictionary,
    isSaveTokensInUserDefaults: true,
    connectionStatus: { success, feedbackStatus, token in },
    errorStatus: { udError, description in }
)
```

### Parameters returned by the block

****СonnectionStatus****

| Type | Description |
| --- | --- |
| Bool | Successful connection to the chat |
| UDFeedbackStatus | Feedback form display status |
| String | User token |

****ErrorStatus****

| Type | Description |
| --- | --- |
| UDError | Documented error type |
| String? | Error description |


## Documentation

Methods for working with the SDK, customization of elements, and errors are described in our documentation: [https://sdk.usedocs.com](https://sdk.usedocs.com/)

## Authors

Sergey, kon.sergius@gmail.com

## ****License****

UseDesk_SDK_Swift is available under the MIT license. See the LICENSE file for more info
