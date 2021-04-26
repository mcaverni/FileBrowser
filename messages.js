function getCopyMessage(file1, file2) {
    var s = qsTr("Do you want to copy\n<file1>\nto\n<file2>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}

function getMoveMessage(file1, file2) {
    var s = qsTr("Do you want to move\n<file1>\nto\n<file2>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}

function getRenameMessage(file1, file2) {
    var s = qsTr("Do you want to rename\n<file1>\nto\n<file2>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}

function getDeleteMessage(file1) {
    var s = qsTr("Do you want to delete\n<file1>\nforever?");
    s = s.replace("<file1>", file1);
    return s;
}

function getNewFolderMessage(file1, file2) {
    var s = qsTr("Do you want to create a new folder\n<file2>\ninto\n<file1>?");
    s = s.replace("<file1>", file1);
    s = s.replace("<file2>", file2);
    return s;
}
