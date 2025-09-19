// swift-tools-version: 5.9
import PackageDescription
import AppleProductTypes

let package = Package(
    name: "SimpleLockWidget",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .iOSApplication(
            name: "SimpleLockWidget",
            targets: ["SimpleLockWidgetApp"],
            bundleIdentifier: "com.example.simplelockwidget",
            teamIdentifier: "ABCDE12345",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .text("SL"), backgroundColor: .indigo),
            accentColor: .presetColor(.indigo),
            supportedDeviceFamilies: [
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait
            ],
            capabilities: [
                .appGroups(["group.com.example.simplelockwidget"])
            ],
            extensions: [
                .widget(
                    name: "SimpleLockWidgetWidget",
                    targets: ["LockScreenWidget"]
                )
            ]
        )
    ],
    targets: [
        .target(
            name: "SharedConstants",
            path: "Sources/Shared"
        ),
        .executableTarget(
            name: "SimpleLockWidgetApp",
            dependencies: ["SharedConstants"],
            path: "Sources/AppModule",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "LockScreenWidget",
            dependencies: ["SharedConstants"],
            path: "Sources/LockScreenWidget",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
