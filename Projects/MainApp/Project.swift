import ProjectDescription

let project = Project(name: "MLClone",
                      organizationName: "Décio Montanhani",
                      packages: [
                        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "6.0.0")),
                        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.0.0"))
                      ],
                      targets: [
                        Target(name: "MLClone",
                               platform: .iOS,
                               product: .app,
                               bundleId: "br.com.deciomontanhani.MLClone",
                               infoPlist: "MLClone/Info.plist",
                               sources: ["MLClone/Sources/**"],
                               resources: ["MLClone/Resources/**"],
                               dependencies: [
                                .project(target: "CommonsUI", path: .relativeToManifest("../CommonsUI")),
                                .project(target: "Alamofake", path: .relativeToManifest("../Alamofake")),
                                .package(product: "Kingfisher")
                               ]),
                        Target(name: "MLCloneTests",
                               platform: .iOS,
                               product: .unitTests,
                               bundleId: "br.com.deciomontanhani.MLCloneTests",
                               infoPlist: "MLCloneTests/Info.plist",
                               sources: ["MLCloneTests/Sources/**"],
                               resources: ["MLCloneTests/Resources/**"],
                               dependencies: [
                                .target(name: "MLClone"),
                                .package(product: "Quick"),
                                .package(product: "Nimble")
                               ])
                      ])
