import SwiftUI

#if os(iOS)

public extension ViewType {
    
    struct EditButton: KnownViewType {
        public static var typePrefix: String = "EditButton"
    }
}

public extension EditButton {
    
    func inspect() throws -> InspectableView<ViewType.EditButton> {
        return try InspectableView<ViewType.EditButton>(self)
    }
}

// MARK: - SingleViewContent

extension ViewType.EditButton: SingleViewContent {
    
    public static func content(view: Any) throws -> Any {
        return try Inspector.attribute(label: "_label", value: view)
    }
}

// MARK: - SingleViewContent

public extension InspectableView where View: SingleViewContent {
    
    func editButton() throws -> InspectableView<ViewType.EditButton> {
        let content = try View.content(view: view)
        return try InspectableView<ViewType.EditButton>(content)
    }
}

// MARK: - MultipleViewContent

public extension InspectableView where View: MultipleViewContent {
    
    func editButton(_ index: Int) throws -> InspectableView<ViewType.EditButton> {
        let content = try contentView(at: index)
        return try InspectableView<ViewType.EditButton>(content)
    }
}

// MARK: - Custom Attributes

public extension InspectableView where View == ViewType.EditButton {
    
    private func editMode() throws -> Binding<EditMode>? {
        let editMode = try Inspector.attribute(label: "editMode", value: view)
        typealias Env = Environment<Binding<EditMode>?>
        guard let environment = editMode as? Env else {
            throw InspectionError.typeMismatch(editMode, Env.self)
        }
        return environment.wrappedValue
    }
}

#endif
