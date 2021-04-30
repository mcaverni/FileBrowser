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

Browser::Browser(QDir startDir) {
  mCurrentDir.setPath(startDir.absolutePath());
  mCurrentDir.setFilter(QDir::Files | QDir::Dirs | QDir::NoDot);
  mCurrentDir.setSorting(QDir::Type | QDir::Name);
  mCurrentDir.refresh();
  setCurrentPath(mCurrentDir.absolutePath());
}

void Browser::down(QString subDirName) {
  qDebug() << "entering folder:" << subDirName;
  if (mCurrentDir.cd(subDirName)) {
    beginResetModel();
    endResetModel();
    emit currentPathChanged();
    qInfo() << "folder changed";
  }
}

void Browser::up() {
  qDebug() << "back to parent folder";
  if (mCurrentDir.cdUp()) {
    beginResetModel();
    endResetModel();
    emit currentPathChanged();

    qInfo() << "folder changed";
  }
}

void Browser::copy(QString fromPath, QString toPath) {
  // TODO: implement
}

void Browser::move(QString fromPath, QString toPath) {
  // TODO: implement
}

void Browser::remove(QString path) {
  // TODO: implement
}

void Browser::newFolder(QString folderName) {
  if (folderName.contains("/")) {
    qWarning() << "please create one folder at a time!";
    return;
  }
  if (!mCurrentDir.mkdir(folderName)) {
    qWarning() << "can't create the folder";
    qWarning() << "reason: something gone bad...";
    return;
  }
  down(folderName);
}

void Browser::rename(QString oldFileName, QString newFileName) {
  QFileInfo source(mCurrentDir.absoluteFilePath(oldFileName));
  QFileInfo destination(mCurrentDir.absoluteFilePath(newFileName));

  if (!source.exists() || !source.isWritable()) {
    qWarning() << "can't rename the file";
    qWarning() << "reason: source issue (no write permissions)";
    return;
  }
  if (destination.exists()) {
    qWarning() << "can't do the operation: rename";
    qWarning() << "reason: destination issue (file exists)";
    return;
  }
  beginResetModel();
  QFile f(source.absoluteFilePath());
  f.rename(destination.absoluteFilePath());
  qInfo() << "rename done:" << oldFileName << "-->" << newFileName;
  // FIXME: doesn't update HMI
  endResetModel();
}

QString Browser::currentPath() const { return mCurrentDir.absolutePath(); }

void Browser::setCurrentPath(QString newPath) {
  if (mCurrentDir.absolutePath() != newPath) {
    if (isValidDir(newPath)) {
      beginResetModel();
      mCurrentDir.setPath(newPath);
      emit currentPathChanged();
      qInfo() << "folder changed";
      endResetModel();
    } else {
      emit wrongPathRequested();
    }
  } else {
    emit rightPathRequested();
  }
}

bool Browser::isValidDir(QString dirPath) const {
  QFileInfo f(dirPath);
  return f.isDir() && f.exists();
}
