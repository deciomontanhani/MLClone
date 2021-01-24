import ProjectDescription

let project = Project(name: "MLClone",
                      organizationName: "Décio Montanhani",
                      targets: [
                        Target(name: "MLClone",
                               platform: .iOS,
                               product: .app,
                               bundleId: "br.com.deciomontanhani.MLClone",
                               infoPlist: "MLClone/Info.plist",
                               sources: ["MLClone/Sources/**"],
                               resources: ["MLClone/Resources/**"],
                               dependencies: [
                            .project(target: "Alamofake", path: .relativeToManifest("../Alamofake"))
                        ]),
                        Target(name: "MLCloneTests",
                               platform: .iOS,
                               product: .unitTests,
                               bundleId: "br.com.deciomontanhani.MLCloneTests",
                               infoPlist: "MLCloneTests/Info.plist",
                               sources: ["MLCloneTests/Sources/**"],
                              //  resources: ["MLCloneTests/Resources/**"],
                               dependencies: [
                                    .target(name: "MLClone")
                               ])
                      ])
