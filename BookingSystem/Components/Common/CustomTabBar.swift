//
//  CustomTabBar.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: Pages
    let tabItems: [TabItem]
    let titleSize: Int
    
    var body: some View {
        HStack {
            
            Spacer()
            
            ForEach(tabItems.indices, id: \.self) { index in
                TabBarItem(
                    item: tabItems[index],
                    isSelected: tabItems[index].tab == selectedTab,
                    onTap: {
                        selectedTab = tabItems[index].tab
                    }, titleSize: titleSize
                )
                Spacer()
            }
        }
        
    }
}

struct TabItem {
    let icon: String
    let title: String
    let tab: Pages
}

struct TabBarItem: View {
    let item: TabItem
    let isSelected: Bool
    let onTap: () -> Void
    let titleSize: Int
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(systemName: item.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .blackWhite : .gray)
                
                Text(item.title)
                    .font(.system(size: CGFloat(titleSize)))
                    .foregroundColor(isSelected ? .blackWhite : .gray)
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
        }
    }
}
