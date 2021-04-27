function getCopyMessage(file1, file2) {
    var s = qsTr("Do you want to copy\n\n<file1>\n\nto\n\n<file2>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}

function getMoveMessage(file1, file2) {
    var s = qsTr("Do you want to move\n\n<file1>\n\nto\n\n<file2>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}

function getRenameMessage(file1, file2) {
    var s = qsTr("Do you want to rename\n\n<file1>\n\nto\n\n<file2>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}

function getRemoveMessage(file1) {
    var s = qsTr("Do you want to remove\n\n<file1>\n\nforever?");
    s = s.replace("<file1>", file1);
    return s;
}

function getNewFolderMessage(file1, file2) {
    var s = qsTr("Do you want to create a new folder\n\n<file2>\n\ninto\n\n<file1>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}
