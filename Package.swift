// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

 let package = Package(
     name: "BFNavigationController",
     platforms: [
         .macOS(.v10_13)
     ],
     products: [
         .library(
             name: "BFNavigationController",
             targets: ["BFNavigationController"])
     ],
     targets: [
         .target(
             name: "BFNavigationController",
             path: "",
             sources: ["BFNavigationController"],
             publicHeadersPath: "BFNavigationController",
             cSettings: [
                 .headerSearchPath("BFNavigationController")
             ]
         )
     ]
 )
