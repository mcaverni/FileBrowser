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

int Browser::rowCount(const QModelIndex &parent) const {
  Q_UNUSED(parent)
  return mCurrentDir.count();
}

QVariant Browser::data(const QModelIndex &index, int role) const {
  QFileInfo f = mCurrentDir.entryInfoList().at(index.row());
  QString resultString;
  switch (role) {
  case MyRoles::Name:
    resultString = f.fileName();
    break;
  case MyRoles::Icon:
    if (mCurrentDir == QDir::root())
      resultString = "qrc:/icons/hard-drive-4x.png";
    else if (mCurrentDir == QDir::home())
      resultString = "qrc:/icons/home-4x.png";
    else if (f.isDir())
      resultString = "qrc:/icons/folder-4x.png";
    else if (f.isSymLink())
      resultString = "qrc:/icons/link-intact-4x.png";
    else if (f.isFile()) {
      if (false)
        resultString = "qrc:/icons/document-4x.png";
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
    else
      resultString = "file";
    break;
  case MyRoles::Size:
    if (f.isFile())
      resultString = QString::number(f.size() / 1000.f, 'g', 1).append("kB");
    else
      resultString = "-";
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
