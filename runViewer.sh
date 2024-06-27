#!/bin/zsh

VERSION=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
if [[ $VERSION == '' ]]; then
  echo "Java is not installed"
  exit 1
fi
rm -f nohup.out
echo "Java Version : $VERSION"
if [[ $VERSION == 1.8.* ]]; then
  nohup java -jar STIGViewer-2.17.jar &
else
  if [[ ! -d javafx-sdk-21.0.3 ]]; then
    if [[ $(uname -p) == arm ]]; then
      wget https://download2.gluonhq.com/openjfx/21.0.3/openjfx-21.0.3_osx-aarch64_bin-sdk.zip
    else
      wget https://download2.gluonhq.com/openjfx/21.0.3/openjfx-21.0.3_osx-x64_bin-sdk.zip
    fi
    unzip *.zip
    rm *.zip
  fi
  nohup java --module-path javafx-sdk-21.0.3/lib --add-modules javafx.controls,javafx.fxml,javafx.web -jar STIGViewer-2.17.jar &
fi
