//
//  FirstWidgetView.swift
//  SimpleWidget
//
//  Created by Lia on 2021/10/05.
//

import WidgetKit
import SwiftUI

struct FirstWidgetEntryView : View {
    var model: UserWidget

    var body: some View {
        Text(entry.date, style: .time)
    }
}

struct FirstWidget_Previews: PreviewProvider {
    static var previews: some View {
        FirstWidgetEntryView(entry: snapshotEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
