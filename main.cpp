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
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <browser.h>

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;

  // ** prepare components for QML
  qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:///Style.qml")),
                           "app.style", 1, 0, "Style");

  Browser *left = new Browser();
  engine.rootContext()->setContextProperty("BrowserLeft", left);

  Browser *right = new Browser();
  engine.rootContext()->setContextProperty("BrowserRight", right);
  // ** done

  const QUrl url(QStringLiteral("qrc:/main.qml"));
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
          QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
