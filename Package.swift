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
         .package(url: "https://github.com/johnxnguyen/Down", from: "0.11.0")
     ],
     targets: [
         .target(
             name: "UseDesk",
             dependencies: [
                 "Alamofire",
                 "SocketIO",
                 "Down"
             ],
             path: "Sources/UseDesk"
         )
     ],
     swiftLanguageVersions: [.v5]
 )
