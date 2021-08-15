# IkisugiImage

ComputerCraftで汚い画像を表示するプログラム

1.16.5のCC-Tweakedでのみ動作確認しています

![KatyouImage](https://pbs.twimg.com/media/E8xIOIGVoAEq24D?format=jpg&name=large)

# 使用ライブラリ

https://github.com/AlberTajuelo/bitop-lua  
https://github.com/Didericis/png-lua

# インストール方法
インストールしたいディレクトリで以下のコマンドを実行  
wget run https://raw.githubusercontent.com/MORIMORI0317/IkisugiImage/main/src/ikisugiimage_installer.lua  
生成されたikisugiimage.luaを実行

#画像の追加方法
PNG形式の画像を用意する(PNG以外の場合はFFmpegとか変換サイトを利用してどうぞ)  
用意したPNG画像をgimpで画像モードをインデックスにする（Filter Typeを1にできれば何でも良き）
![KatyouImage](https://cdn.discordapp.com/attachments/523502209988821033/876596611936055356/2021-08-16_07h41_52.png)  
完成したPNGをインストールしたディレクトリ内のimages内にwget等でダウンロードする  
editでikisugiimage.lua内のlocal images = {...}に画像のパスを加え、mirrorとrotedには0,tureで実際に実行して反転してたりしたらいろいろ変更する
