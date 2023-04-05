# UseDesk
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

# Добавление библиотеки в проект:

### Swift Package Manager

```swift
.package(url: "https://github.com/usedesk/UseDeskSPM.git", from: "1.3.0")
```

## Инициализация SDK 

### Параметры, используемые в конфигурации SDK

Где * — обязательный параметр

| **Переменная** | **Тип** | **Описание** |
| --- | --- | --- |
| **CompanyID*** | String | **Идентификатор компании в Юздеске**<br/>[Как найти ID компании](https://docs.usedesk.ru/article/61) |
| **ChannelID*** | String | **Идентификатор канала чата, через который в Юздеск будут поступать обращения из приложения**<br/>[Как создать и настроить канал](https://docs.usedesk.ru/article/858) |
| **Url*** | String | **Адрес сервера для работы с чатами SDK**<br/>Стандартное значение: `pubsubsec.usedesk.ru`<br/>Если вы используете коробочную версию Юздеска на собственном сервере, то этот параметр у вас может отличаться. Уточните актуальный адрес у поддержки — support@usedesk.ru |
| **Port** | String | **Порт сервера для работы с чатами SDK**<br/>Стандартное значение: `443` |
| **UrlAPI*** | String | **URL для работы с API**<br/>Стандартное значение: `secure.usedesk.ru/uapi`<br/>Если вы используете коробочную версию Юздеска на собственном сервере, то этот параметр у вас будет отличаться. Уточните актуальный адрес у поддержки — support@usedesk.ru |
| **API_token** | String | **Ключ для доступа к API Юздеска**<br/>[Как получить API ключ](https://docs.usedesk.ru/article/10167) |
| **KnowledgeBaseID** | String | **Идентификатор базы знаний**<br/>[Как создать Базу знаний](https://docs.usedesk.ru/article/1678)<br/>**Если ID не указан, база знаний не используется** |
| **UrlToSendFile** | String | **Адрес для отправки файлов**<br/>Стандартное значение: `https://secure.usedesk.ru/uapi/v1/send_file` |
| **Name** | String | **Имя клиента** |
| **Email** | String | **Почта клиента** |
| **Phone** | String | **Телефон клиента** |
| **Avatar** | Data? | **Изображение аватара клиента** |
| **AvatarUrl** | URL? | **URL изображения аватара клиента**<br/>Приоритет имеет параметр Avatar|
| **Token** | String | **Подпись, однозначно идентифицирующая пользователя и его чат**<br/>Токен выдается в коллбэке после инициализации чата и привязывается к связке почта-телефон-имя пользователя.<br/>Для идентификации различных пользователей на одном устройстве вы должны хранить и передавать полученный токен в метод инициализации |
| **AdditionalId** | String | **Дополнительный идентификатор клиента** |
| **Note** | String | **Текст заметки** |
| **AdditionalFields** | [Int : String] | **Массив дополнительный полей запроса**<br/>Формат: `id : "значение"`<br/>Для текстовых полей значение - строка, для списка - строка с точно совпадающим значением списка, для флага - строка `false` или `true` |
| **AdditionalNestedFields** | [[Int : String]] | **Массив дополнительных полей типа вложенный список**<br/>Каждый подмассив представляет один вложенный список. <br/>Формат вложенного списка: `[id1: "значение", id2 : "значение", id3 : "значение"]`, где `id1`, `id2`, `id3` — идентификаторы значений по уровням вложенности |
| **FirstMessage** | String | **Автоматическое сообщение**<br/>Отправится сразу после инициализации от имени клиента |
| **CountMessagesOnInit** | Int | **Количество загружаемых сообщений при открытии чата**<br/>При открытии чата загружается указанное количество сообщений. По мере прокрутки чата подгружается по 20 сообщений |
| **LocaleIdentifier** | String | **Идентификатор языка**<br/>Доступные языки: русский (`ru`), английский (`en`), португальский (`pt`), испанский (`es`). <br/>Если переданный идентификатор не поддерживается, будет использоваться русский язык |
| **CustomLocale** | [String : String] | **Свой словарь переводов**<br/>Если SDK нужно показывать на языке, который мы не поддерживаем, можно самостоятельно создать словарь переводов и использовать его |
| **isSaveTokensInUserDefaults** | Bool | **Флаг сохранения токена пользователя в UserDefaults приложения**<br/>Стандартное значение: `true`<br/>Если указан `true`, то токен будет храниться в текущем устройстве. Недостатки такого подхода — при переустановке приложения, смене устройства или платформы доступ к переписке будет утрачен. <br/>Для сохранения доступа к переписке клиента с других устройств и платформ,  токен необходимо хранить в вашей системе и передавать его при инициализации. В этом случае нужно использовать значение параметра `false` |


### Инициализация SDK 

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

### Параметры, которые возвращает блок

****СonnectionStatus****

| Тип | Описание |
| --- | --- |
| Bool | Успешность подключения к чату |
| UDFeedbackStatus | Статус показа формы обратной связи |
| String | Токен пользователя |

****ErrorStatus****

| Тип | Описание |
| --- | --- |
| UDError | Задокументированый тип ошибки |
| String? | Описание ошибки |


## Документация:

Методы для работы с SDK и ошибки описаны в нашей документации: [http://sdk.usedocs.ru](http://sdk.usedocs.ru/)

## Автор

Сергей, kon.sergius@gmail.com

## ****License****

UseDesk_SDK_Swift is available under the MIT license. See the LICENSE file for more info

