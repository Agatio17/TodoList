import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Todo List")

    ListModel {
        id: todoModel
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: headerRect
            height: 100
            width: parent.width
            color: "#721F1F"
            anchors.top: parent.top

            Text {
                text: "My Todo List"
                font.bold: true
                color: "white"
                font.pixelSize: 32
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 35
            }
        }

        Item {
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.top: headerRect.bottom

            Rectangle {
                id: leftRect
                width: 0.5 * parent.width
                height: parent.height
                anchors.left: parent.left
                color: "#C4C4C4"

                ListView {
                    id: todoList
                    model: todoModel
                    spacing: 5
                    anchors.centerIn: parent
                    width: parent.width * 0.7
                    height: parent.height * 0.8

                    delegate: Rectangle {
                        id: todoListDelegate
                        width: todoList.width
                        height: 100
                        color: "white"
                        radius: 10

                        property string title
                        property string description

                        title: _title
                        description: _description

                        Rectangle {
                            color: "red"
                            width: 100
                            radius: 10
                            height: parent.height
                            anchors.right: parent.right

                            Text {
                                color: "white"
                                font.bold: true
                                font.pixelSize: 18
                                text: "Delete"
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    todoModel.remove(index)
                                }
                            }
                        }

                        Column {
                            anchors.fill: parent
                            anchors.leftMargin: 20
                            anchors.rightMargin: 100
                            anchors.topMargin: 5
                            anchors.bottomMargin: 5

                            Text {
                                color: "black"
                                font.bold: true
                                font.pixelSize: 18
                                text: todoListDelegate.title
                            }

                            Text {
                                color: "black"
                                font.pixelSize: 16
                                text: todoListDelegate.description
                            }
                        }
                    }
                }
            }

            Item {
                id: rightItem
                width: 0.5 * parent.width
                height: parent.height
                anchors.right: parent.right

                Column {
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    TextField {
                        id: titleField
                        placeholderText: "Enter the title"
                        height: 50
                        width: rightItem.width * 0.7
                        color: "black"
                    }

                    TextArea {
                        id: descriptionField
                        placeholderText: "Enter the TODO description"
                        width: rightItem.width * 0.7
                        height: 400
                    }

                    Button {
                        text: "Add"
                        height: 50
                        width: rightItem.width * 0.7

                        onClicked: {
                            todoModel.append({ "_title": titleField.text, "_description": descriptionField.text })
                            titleField.clear()
                            descriptionField.clear()
                        }
                    }
                }
            }
        }
    }
}
