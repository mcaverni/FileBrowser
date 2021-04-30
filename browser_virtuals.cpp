/*
===================================================================================
Copyright (C) 2021 by Frigel Firenze.
https://www.frigel.com

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

If not, please request a copy in writing from Frigel Firenze at the address
below. If you have questions concerning this license or the applicable
additional terms, you may contact in writing Frigel Firenze, Via Pisana, 316,
50018 Scandicci FI.
===================================================================================
*/
#include "browser.h"

static QHash<int, QByteArray> myRoleNames = {{MyRoles::Icon, "icon"},
                                             {MyRoles::Name, "name"},
                                             {MyRoles::Type, "type"},
                                             {MyRoles::Path, "path"},
                                             {MyRoles::Size, "size"}};

QSet<QString> myDocsTypes = {"txt", "doc", "docx", "rtf"};
QSet<QString> myImgTypes = {"png", "jpg", "jpeg", "svg", "pdf"};

int Browser::rowCount(const QModelIndex &parent) const {
  Q_UNUSED(parent)
  return mCurrentDir.count();
}

QVariant Browser::data(const QModelIndex &index, int role) const {
  QFileInfo f = mCurrentDir.entryInfoList().at(index.row());
  // can't do up on root
  if (mCurrentDir.isRoot() && index.row() == 0)
    return QVariant();

  QString resultString;
  switch (role) {
  case MyRoles::Name:
    resultString = f.fileName();
    break;
  case MyRoles::Icon:
    if (f.absoluteFilePath() == QDir::root().absolutePath())
      resultString = "qrc:/icons/hard-drive-4x.png";
    else if (f.absoluteFilePath() == QDir::home().absolutePath())
      resultString = "qrc:/icons/home-4x.png";
    else if (f.isDir())
      resultString = "qrc:/icons/folder-4x.png";
    else if (f.isSymLink())
      resultString = "qrc:/icons/link-intact-4x.png";
    else if (f.isFile()) {
      if (myDocsTypes.contains(f.suffix().toLower()))
        resultString = "qrc:/icons/document-4x.png";
      else if (myImgTypes.contains(f.suffix().toLower()))
        resultString = "qrc:/icons/image-4x.png";
      else
        resultString = "qrc:/icons/file-4x.png";
    } else
      resultString = "";
    break;
  case MyRoles::Type:
    if (f.isDir())
      resultString = "dir";
    else if (f.isSymLink())
      resultString = "link";
    else {
      if (myDocsTypes.contains(f.suffix().toLower()))
        resultString = "text";
      else if (myImgTypes.contains(f.suffix().toLower()))
        resultString = "image";
      else
        resultString = "file";
    }
    break;
  case MyRoles::Size:
    if (!f.isFile())
      resultString = "-";
    else {
      if (f.size() < pow(10, 3))
        resultString = QString::number(f.size()).append("B");
      else if (f.size() < pow(10, 6))
        resultString =
            QString::number(double(f.size()) / pow(10, 3), 'f', 2).append("kB");
      else if (f.size() < pow(10, 9))
        resultString =
            QString::number(double(f.size()) / pow(10, 6), 'f', 2).append("MB");
      else // if (f.size() < pow(10, 6))
        resultString =
            QString::number(double(f.size()) / pow(10, 9), 'f', 2).append("GB");
    }
    break;
  case MyRoles::Path:
    resultString = f.absoluteFilePath();
    break;
  default:
    qCritical() << "unrecognized role for index" << index;
    break;
  }
  return resultString;
}

QHash<int, QByteArray> Browser::roleNames() const { return myRoleNames; }
