import SwiftUI

struct ProfileView: View {
    @StateObject private var listingsViewModel = ListingsViewModel()
    @State private var selectedTab = 0 // 0 for Listings, 1 for Likes

    @ObservedObject private var userManager = UserManager.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding([.top, .trailing])

                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray)

                        VStack(alignment: .leading) {
                            if let user = userManager.user {
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.title2)
                                    .fontWeight(.bold)

                                NavigationLink(destination: ReviewsView()) {
                                    HStack(spacing: 2) {
                                        Text("\(user.rating, specifier: "%.1f")")
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .foregroundColor(.primary)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    if let user = userManager.user {
                        HStack(spacing: 16) {
                            NavigationLink(destination: FollowerView(followerIDs: user.followers, followingIDs: user.following)) {
                                Text("\(user.followers.count) followers")
                                    .foregroundColor(.blue)
                            }

                          NavigationLink(destination: FollowingView()) {
                                Text("\(user.following.count) following")
                                    .foregroundColor(.blue)
                            }
                            Text("0 rented")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)

                        HStack {
                            Image(systemName: "graduationcap.fill")
                            Text(user.university)
                            NavigationLink(destination: EditProfileView()) {
                                Text("edit profile")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 8)
                            }
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("MediumBlue"), Color("MediumGreen")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(20)
                            .shadow(radius: 2)
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                    }

                    Divider()

                    Picker("", selection: $selectedTab) {
                        Text("Listings (\(listingsViewModel.listingsCount))").tag(0)
                        Text("Likes").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    if selectedTab == 0 {
                        ListingsProfileView()
                            .environmentObject(listingsViewModel)
                    } else {
                        LikesView()
                            .environmentObject(listingsViewModel)
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Profile")
            .onAppear {
                listingsViewModel.fetchListings()
            }
        }
    }
}
