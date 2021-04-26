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
  // start from $HOME on creation
  myDir = startDir;
}

void Browser::browse(QString newPlace) {
  // TODO
  qDebug() << "opening location:" << newPlace;
}

void Browser::copy(QString fromPath, QString toPath) {}

void Browser::move(QString fromPath, QString toPath) {}

void Browser::remove(QString path) {}

QModelIndex Browser::index(int row, int column,
                           const QModelIndex &parent) const {}

QModelIndex Browser::parent(const QModelIndex &child) const {}

int Browser::rowCount(const QModelIndex &parent) const {}

int Browser::columnCount(const QModelIndex &parent) const {}

QVariant Browser::data(const QModelIndex &index, int role) const {}
