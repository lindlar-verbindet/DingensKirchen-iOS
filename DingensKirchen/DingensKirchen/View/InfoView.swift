//
//  InfoView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 28.10.21.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .bottom){
                    Spacer()
                    Image(systemName: "info")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 120, alignment: .center)
                        .padding(.trailing, 20)
                        .foregroundColor(.primaryBackground)
                }
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primaryBackground)
                    .padding(.top, -10)
                    .ignoresSafeArea()
            }
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 120)
                    NavigationLink(destination: DKWebView(urlString: "https://www.lindlar-verbindet.de/impressum/")) {
                        Text("info_imprint")
                            .font(Font.system(size: 20, weight: .light))
                            .padding(EdgeInsets(top: 40, leading: 50, bottom: 0, trailing: 50))
                            .foregroundColor(.black)
                    }
                    NavigationLink(destination: DKWebView(urlString: "https://www.lindlar-verbindet.de/datenschutz/")) {
                        Text("info_datapolicy")
                            .font(Font.system(size: 20, weight: .light))
                            .padding(EdgeInsets(top: 10, leading: 50, bottom: 0, trailing: 50))
                            .foregroundColor(.black)
                    }
                    NavigationLink(destination: DKWebView(urlString: "https://www.lindlar-verbindet.de/feedback-anregungen-ideen/")) {
                        Text("FEEDBACK")
                            .font(Font.system(size: 20, weight: .light))
                            .padding(EdgeInsets(top: 10, leading: 50, bottom: 0, trailing: 50))
                            .foregroundColor(.black)
                    }
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .padding(.top, 80)
                    
                    VStack(alignment: .leading) {
                        Text("info_sponsor_headline")
                            .font(Font.system(size: 16, weight: .bold))
                            .padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50))
                        NavigationLink(destination: DKWebView(urlString: NSLocalizedString("info_sponsor_url", comment: ""))) {
                            Text("info_sponsor")
                                .font(Font.system(size: 16, weight: .light))
                                .padding(EdgeInsets(top: 10, leading: 50, bottom: 0, trailing: 50))
                                .foregroundColor(.black)
                        }
                        
                        Text("info_owner_headline")
                            .font(Font.system(size: 16, weight: .bold))
                            .padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50))
                        NavigationLink(destination: DKWebView(urlString: NSLocalizedString("info_owner_url", comment: ""))) {
                            Text("info_owner")
                                .font(Font.system(size: 16, weight: .light))
                                .padding(EdgeInsets(top: 10, leading: 50, bottom: 0, trailing: 50))
                                .foregroundColor(.black)
                        }
                        
                        Text("info_concept_headline")
                            .font(Font.system(size: 16, weight: .bold))
                            .padding(EdgeInsets(top: 50, leading: 50, bottom: 0, trailing: 50))
                        NavigationLink(destination: DKWebView(urlString: NSLocalizedString("info_concept_url", comment: ""))) {
                            Text("info_concept")
                                .font(Font.system(size: 16, weight: .light))
                                .padding(EdgeInsets(top: 10, leading: 50, bottom: 0, trailing: 50))
                                .foregroundColor(.black)
                        }
                        
                        NavigationLink(destination: DKWebView(urlString: NSLocalizedString("info_repo_url", comment: ""))) {
                            Text("info_repo")
                                .font(Font.system(size: 16, weight: .bold))
                                .padding(EdgeInsets(top: 10, leading: 50, bottom: 0, trailing: 50))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(5)
                }
                Spacer()
            }
        }
        .navigationTitle("info_navigation_title")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
