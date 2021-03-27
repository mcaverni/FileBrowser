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

If not, please request a copy in writing from Frigel Firenze at the address below.
If you have questions concerning this license or the applicable additional terms,
you may contact in writing Frigel Firenze, Via Pisana, 316, 50018 Scandicci FI.
===================================================================================
*/
#ifndef MYLISTMODEL_H
#define MYLISTMODEL_H

#include <QAbstractItemModel>
#include <QObject>

class MyListModel : public QAbstractItemModel
{
    Q_OBJECT
public:
    MyListModel();
};

#endif // MYLISTMODEL_H
