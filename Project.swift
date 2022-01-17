import ProjectDescription

// 1
let project = Project(
  name: "Marvel",
  organizationName: "Globant",
  packages: [
        Package.remote(
        url: "https://github.com/onevcat/Kingfisher.git",
        requirement: .upToNextMajor(
            from: Version(6, 3, 1)
        )
        ),
        Package.remote(
        url: "https://github.com/Moya/Moya.git",
        requirement: .upToNextMajor(
            from: Version(15, 0, 0)
        )
        )
  ],
  targets: [
    Target(
      name: "Marvel",
      platform: .iOS,
      product: .app,
      bundleId: "com.Globant.Marvel",
      infoPlist: "Marvel/Source/Info.plist",
      sources: ["Marvel/Source/**"],
      resources: ["Marvel/Resources/**", "Marvel/Source/Presentation/CharacterList/Cell/CharacterCell.xib"],
      dependencies: [
        .package(product: "Kingfisher"),
        .package(product: "Moya")
      ],
      settings: nil),
    Target(
      name: "MarvelTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.Globant.MarvelTests",
      infoPlist: "MarvelTests/Source/Info.plist",
      sources: ["MarvelTests/Source/**"],
      resources: ["MarvelTests/Resources/**"],
      dependencies: [
        .target(name: "Marvel")
      ]
    )
])
