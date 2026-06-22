//
//  ProspectView.swift
//  HotProspects
//
//  Created by Michael Peralta on 6/11/26.
//

import AVFoundation
import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    enum SortType {
        case name, mostRecent
    }
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State private var selectedSort: SortType = .name

    let filter: FilterType

    var title: String {
        switch filter {
        case .none: return "Everyone"
        case .contacted: return "Contacted people"
        case .uncontacted: return "Uncontacted people"
        }
    }

    var sortedProspects: [Prospect] {
        switch selectedSort {
        case .name:
            prospects.sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name)
                    == .orderedAscending
            }
        case .mostRecent:
            prospects.sorted { $0.addedDate > $1.addedDate }
        }
    }

    var body: some View {
        NavigationStack {
            List(sortedProspects, selection: $selectedProspects) { prospect in
                NavigationLink {
                    ProspectEditView(prospect: prospect)
                        .onDisappear {
                            selectedProspects.remove(prospect)
                        }
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)

                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Section {
                            switch prospect.isContacted {
                            case true:
                                Image(
                                    systemName:
                                        "person.crop.circle.fill.badge.checkmark"
                                )
                                .foregroundColor(.green)
                            case false:
                                Image(
                                    systemName: "person.crop.circle.badge.xmark"
                                )
                                .foregroundColor(.red)
                            }
                        }
                    }
                }
                .swipeActions {
                    Button(
                        "Delete",
                        systemImage: "trash",
                        role: .destructive
                    ) {
                        modelContext.delete(prospect)
                    }

                    if prospect.isContacted {
                        Button(
                            "Mark Uncontacted",
                            systemImage: "person.crop.circle.badge.xmark"
                        ) {
                            prospect.isContacted.toggle()

                        }
                        .tint(Color.blue)
                    } else {
                        Button(
                            "Mark Contacted",
                            systemImage:
                                "person.crop.circle.fill.badge.checkmark"
                        ) {
                            prospect.isContacted.toggle()
                        }
                        .tint(Color.green)

                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }

                        .tint(Color.orange)
                    }
                }
                .tag(prospect)

            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Menu {
                            Picker("Sort by", selection: $selectedSort) {
                                Text("Name").tag(SortType.name)
                                Text("Most Recent").tag(SortType.mostRecent)
                            }
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }

                        if selectedProspects.isEmpty {
                            Button("Scan", systemImage: "qrcode.viewfinder") {
                                isShowingScanner = true
                            }
                        } else {
                            Button("Delete Selected", action: delete)
                        }
                    }

                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "Michael\nm.peralta@test.com",
                    completion: handleScan
                )
            }
        }
    }

    init(filter: FilterType) {
        self.filter = filter
        if filter != .none {
            let showContactedOnly = filter == .contacted
            _prospects = Query(
                filter: #Predicate {
                    $0.isContacted == showContactedOnly
                },
                sort: \Prospect.name
            )
        }
    }

    //    init(filter: FilterType, sort: SortType) {
    //        self.filter = filter
    //
    //        let sortDescriptors: [SortDescriptor<Prospect>] =
    //        switch sort {
    //        case .mostRecent:
    //            [SortDescriptor(\Prospect.addedDate)]
    //        case .name:
    //            [SortDescriptor(\Prospect.name)]
    //
    //        }
    //
    //        if filter != .none {
    //            let showContactedOnly = filter == .contacted
    //
    //            _prospects = Query(
    //                filter: #Predicate {
    //                    $0.isContacted == showContactedOnly
    //                },
    //                sort: sortDescriptors
    //            )
    //        } else {
    //            _prospects = Query(sort: sortDescriptors)
    //        }
    //    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect(
                name: details[0],
                emailAddress: details[1],
                isContacted: false
            )
            modelContext.insert(person)

        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")

        }

    }

    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = "\(prospect.emailAddress)"
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 5,
                repeats: false
            )

            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .sound, .badge]) {
                    success,
                    error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }

            }

        }
    }
}

#Preview {
    ProspectView(filter: .none)
        .modelContainer(for: Prospect.self)
}
