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
#ifndef BROWSER_H
#define BROWSER_H

#include <QAbstractListModel>
#include <QDebug>
#include <QDir>
#include <QObject>

enum MyRoles { Icon = Qt::UserRole, Name, Type, Size, Path };

class Browser : public QAbstractListModel {
  Q_OBJECT
  QDir mCurrentDir; // the content displayed
  Q_PROPERTY(QString currentPath READ currentPath WRITE setCurrentPath NOTIFY
                 currentPathChanged);

public: // Q_PROPERTY interface
  QString currentPath() const;
  void setCurrentPath(QString newPath);
  bool isValidDir(QString dirPath) const;

signals:
  void currentPathChanged();
  void rightPathRequested();
  void wrongPathRequested();

public:
  Browser(QDir startDir = QDir::home());

  // QML navigation on click (or keyboard...)
  Q_INVOKABLE void down(QString subDir);
  Q_INVOKABLE void up();

  // QML button actions
  Q_INVOKABLE void copy(QString fromPath, QString toPath);
  Q_INVOKABLE void move(QString fromPath, QString toPath);
  Q_INVOKABLE void remove(QString path);
  Q_INVOKABLE void newFolder(QString path);
  Q_INVOKABLE void rename(QString fromPath, QString toPath);

signals:
  void contentChanged(); // only the content, the path is the same

  // QAbstractItemModel interface (see in browser_virtuals.cpp)
public:
  //  QModelIndex index(int row, int column, const QModelIndex &parent) const;
  //  QModelIndex parent(const QModelIndex &child) const;
  //  int columnCount(const QModelIndex &parent) const;
  int rowCount(const QModelIndex &parent) const;
  QVariant data(const QModelIndex &index, int role) const;
  QHash<int, QByteArray> roleNames() const;
};

#endif // BROWSER_H
