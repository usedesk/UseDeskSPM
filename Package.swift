// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package (
     name: "UseDesk",
    platforms: [
        .iOS(.v10)
    ],
     products: [
         .library(name: "UseDesk", targets: ["UseDesk"])
     ],
     dependencies: [
        .package(name: "SocketIO", url: "https://github.com/socketio/socket.io-client-swift", from: "16.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup", from: "2.4.3"),
        .package(url: "https://github.com/bmoliveira/MarkdownKit", from: "1.7.1")
     ],
     targets: [
         .target(
             name: "UseDesk",
             dependencies: [
                 "Alamofire",
                 "SocketIO",
                 "SwiftSoup",
                 "MarkdownKit"
             ],
             path: "Sources/UseDesk"
         )
     ],
     swiftLanguageVersions: [.v5]
 )
