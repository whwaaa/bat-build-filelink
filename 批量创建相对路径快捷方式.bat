:: 作者：吴汉威
:: 日期：2022年12月31日

@echo off&color 0B

echo 脚本简介:  1.为你的大文件目录批量创建快捷方式.
echo            2.创建的快捷方式会保持一致的目录结构位置.
echo            3.快捷方式是相对路径, 不同设备目录下都能正常链接.
echo=
echo 应用场景:  备份工作中使用的大文件
echo=
echo 存在问题:  使用git版本控制系统可以管理工作文件, 但是有些文件太大, 
echo            版本控制系统存在大小限制等等, 但是大文件又不能脱离整体
echo            目录, 不然不好管理.
echo=
echo 解决方案:  大文件存放在大文件目录A, 使用网盘进行同步; 创建快捷方式
echo            到文件目录B, 使用版本控制系统管理; 实现大文件和整体目录
echo            分离存储, echo 但是又能通过快捷方式绑定在原来的目录.
echo=
echo 过于麻烦:  文件太多手动创建快捷方式很麻烦, 并且windows默认创建的快
echo            捷方式使用绝对路径, 移动位置会出现问题, 为了保证同步到不
echo            同设备中仍然正常使用就必须修改为相对路径, 并且手改很麻烦.
echo=
echo 脚本功能:  解决手动创建快捷方式以及修改相对路径等操作的繁琐, 输入源
echo            大文件目录A路径和小文件目录B路径, 自动遍历大文件目录A所
echo            有文件, 在小文件目录B中生成对应目录结构的快捷方式.
echo=
echo=
echo=


::设置需要创建快捷方式的文件夹路径
echo 1.请输入需要创建快捷方式的文件夹路径
echo 目录不能有空格,可以中文但最好不是特殊符号 
echo 例如______: C:\Users\admin\Desktop\项目文档文件夹

set /p "Source=>"
:Source1
if "%Source:~0,1%"==" " set Source=%Source:~1%&goto Source1
::如果存在则去除末尾多余的反斜杠"\"
:Source2
if "%Source:~-1,1%"=="\" (goto tSource2) else (goto endSource2)
:tSource2
set Source=%Source:~0,-1%
goto Source2
:endSource2
::如果存在则去除末尾多余的空格" "
:Source3
if "%Source:~-1,1%"==" " (goto tSource3) else (goto endSource3)
:tSource3
set Source=%Source:~0,-1%
goto Source3
:endSource3

::设置快捷方式保存位置
echo=
echo=
echo 2.快捷方式保存位置
echo 必须要和源文件夹同一目录! 例如:
echo 源文件目录:  C:\Users\admin\Desktop\大文件文档存放目录
echo 生成目录__:  C:\Users\admin\Desktop\项目工程目录
set /p "target=>"
:target
if "%target:~0,1%"==" " set target=%target:~1%&goto target
::如果存在则去除末尾多余的反斜杠"\"
:target2
if "%target:~-1,1%"=="\" (goto tTarget2) else (goto endTarget2)
:tTarget2
set target=%target:~0,-1%
goto target2
:endTarget2
::如果存在则去除末尾多余的空格" "
:target3
if "%target:~-1,1%"==" " (goto tTarget3) else (goto endTarget3)
:tTarget3
set target=%target:~0,-1%
goto target3
:endTarget3

::非同级目录下复制源目录结构
xcopy %Source% %target%  /C /K /T /E /Y /I

::获取源文件夹的目录,即去掉文件夹名
set sourDir=%Source%
:sourDir
if "%sourDir:~-1,1%"=="\" (goto endsourDir) else (goto tsourDir)
:tsourDir
set sourDir=%sourDir:~0,-1%
goto sourDir
:endsourDir

::  echo 源文件夹目录: __%sourDir%__
::  pause

::获取源文件夹名称
set sourceName=%source%
:sourceName
if "%source%"=="%sourDir%%sourceName%" (goto endSourceName) else (goto tSourceName)
:tSourceName
set sourceName=%sourceName:~1%
goto sourceName
:endSourceName

::  echo 源文件夹名称: __%SourceName%__
::  pause


  
::获取目标文件夹的目录
set targetDir=%target%
:targetDir
if "%targetDir:~-1,1%"=="\" (goto endTargetDir) else (goto tTargetDir)
:tTargetDir
set targetDir=%targetDir:~0,-1%
goto targetDir
:endTargetDir

::  echo 目标文件夹目录: __%targetDir%__
::  pause

::获取目标文件夹名称
set targetName=%target%
:targetName
if "%target%"=="%targetDir%%targetName%" (goto endTargetName) else (goto tTargetName)
:tTargetName
set targetName=%targetName:~1%
goto targetName
:endTargetName

::  echo 目标文件夹名称: __%targetName%__
::  pause

::echo 源文件夹目录: __%sourDir%__
::echo 源文件夹名称: __%sourceName%__
::echo 目标文件夹目录: __%targetDir%__
::echo 目标文件夹名称: __%targetName%__

:: 参数 /R 表示需要遍历子文件夹,去掉表示不遍历子文件夹
:: %%f 是一个变量,类似于迭代器,但是这个变量只能由一个字母组成,前面带上%%
:: 括号中是通配符,可以指定后缀名,*.*表示所有文件
for /R %Source% %%f in (*.*) do ( 
call:fileStart %%f
)

::获取目标文件相对路径0(去除源文件夹目录)
:fileStart
set file=%~f1
if "%file%"=="" (goto end) else (goto next)
:next
set targetDirBk=%targetDir%

::  echo file: __%file%__
::  echo targetDirBk: __%targetDirBk%__
::  pause

:file
if "%targetDirBk%"=="" (goto endFile) else (goto tFile)
:tFile
set targetDirBk=%targetDirBk:~1%
set file=%file:~1%
goto file
:endFile
set fileBk=%file%
::  echo 去除源文件夹目录: __%file%__
::  pause

::获取目标文件相对路径1(替换源文件夹目录名称为目标文件夹名targetName)
set SourceNameBk=%SourceName%
:file2
if "%SourceNameBk%"=="" (goto endFile2) else (goto tFile2)
:tFile2
set SourceNameBk=%SourceNameBk:~1%
set file=%file:~1%
goto file2
:endFile2
set file=%targetName%%file%

::  echo 替换源文件夹目录名为目标: __%filelink%__
::  pause

::获取目标文件相对路径2(最终相对路径)
set fileDir=%fileBk%
:ceng 
if "%fileBk%"=="" (goto endCeng) else (goto tCeng)
:tCeng
if "%fileBk:~-1,1%"=="\" (goto tfdir) else (goto tfdir2) 
:tfdir
set fileDir=..\%fileDir%
:tfdir2
set fileBk=%fileBk:~0,-1%
goto ceng
:endCeng

::获取最终快捷方式的全路径
::此处更新直接跳过,不替换后缀
set filelink=%targetDir%%file%
goto toEndlink
:link
if "%filelink:~-1,1%"=="." (goto endLink) else (goto tLink)
:tLink
set filelink=%filelink:~0,-1%
goto link
:endLink
set filelink=%filelink:~0,-1%
:toEndlink
set filelink=%filelink%.lnk

::  echo GET最终源文件相对路径: __%fileDir%__
::  echo GET最终快捷方式路径__: __%filelink%__
::  pause

:setVbsName
set vbsName=makelnk%random%.vbs
if exist %vbsName% ( goto setVbsName ) else ( goto endSetVbsName )
:endSetVbsName

:: 生成调用vbs创建快捷方式
(echo Set WshShell=CreateObject("WScript.Shell"^)
echo Set oShellLink=WshShell.CreateShortcut("%filelink%"^)
echo oShellLink.TargetPath="%%SystemRoot%%\explorer.exe"
echo oShellLink.Arguments="%fileDir%"
echo oShellLink.WindowStyle=1
echo oShellLink.Save)>%vbsName%
%vbsName%
del /f /q %vbsName%

echo %filelink%

:end