:: ���ߣ��⺺��
:: ���ڣ�2022��12��31��

@echo off&color 0B

echo �ű����:  1.Ϊ��Ĵ��ļ�Ŀ¼����������ݷ�ʽ.
echo            2.�����Ŀ�ݷ�ʽ�ᱣ��һ�µ�Ŀ¼�ṹλ��.
echo            3.��ݷ�ʽ�����·��, ��ͬ�豸Ŀ¼�¶�����������.
echo=
echo Ӧ�ó���:  ���ݹ�����ʹ�õĴ��ļ�
echo=
echo ��������:  ʹ��git�汾����ϵͳ���Թ������ļ�, ������Щ�ļ�̫��, 
echo            �汾����ϵͳ���ڴ�С���Ƶȵ�, ���Ǵ��ļ��ֲ�����������
echo            Ŀ¼, ��Ȼ���ù���.
echo=
echo �������:  ���ļ�����ڴ��ļ�Ŀ¼A, ʹ�����̽���ͬ��; ������ݷ�ʽ
echo            ���ļ�Ŀ¼B, ʹ�ð汾����ϵͳ����; ʵ�ִ��ļ�������Ŀ¼
echo            ����洢, echo ��������ͨ����ݷ�ʽ����ԭ����Ŀ¼.
echo=
echo �����鷳:  �ļ�̫���ֶ�������ݷ�ʽ���鷳, ����windowsĬ�ϴ����Ŀ�
echo            �ݷ�ʽʹ�þ���·��, �ƶ�λ�û��������, Ϊ�˱�֤ͬ������
echo            ͬ�豸����Ȼ����ʹ�þͱ����޸�Ϊ���·��, �����ָĺ��鷳.
echo=
echo �ű�����:  ����ֶ�������ݷ�ʽ�Լ��޸����·���Ȳ����ķ���, ����Դ
echo            ���ļ�Ŀ¼A·����С�ļ�Ŀ¼B·��, �Զ��������ļ�Ŀ¼A��
echo            ���ļ�, ��С�ļ�Ŀ¼B�����ɶ�ӦĿ¼�ṹ�Ŀ�ݷ�ʽ.
echo=
echo=
echo=


::������Ҫ������ݷ�ʽ���ļ���·��
echo 1.��������Ҫ������ݷ�ʽ���ļ���·��
echo Ŀ¼�����пո�,�������ĵ���ò���������� 
echo ����______: C:\Users\admin\Desktop\��Ŀ�ĵ��ļ���

set /p "Source=>"
:Source1
if "%Source:~0,1%"==" " set Source=%Source:~1%&goto Source1
::���������ȥ��ĩβ����ķ�б��"\"
:Source2
if "%Source:~-1,1%"=="\" (goto tSource2) else (goto endSource2)
:tSource2
set Source=%Source:~0,-1%
goto Source2
:endSource2
::���������ȥ��ĩβ����Ŀո�" "
:Source3
if "%Source:~-1,1%"==" " (goto tSource3) else (goto endSource3)
:tSource3
set Source=%Source:~0,-1%
goto Source3
:endSource3

::���ÿ�ݷ�ʽ����λ��
echo=
echo=
echo 2.��ݷ�ʽ����λ��
echo ����Ҫ��Դ�ļ���ͬһĿ¼! ����:
echo Դ�ļ�Ŀ¼:  C:\Users\admin\Desktop\���ļ��ĵ����Ŀ¼
echo ����Ŀ¼__:  C:\Users\admin\Desktop\��Ŀ����Ŀ¼
set /p "target=>"
:target
if "%target:~0,1%"==" " set target=%target:~1%&goto target
::���������ȥ��ĩβ����ķ�б��"\"
:target2
if "%target:~-1,1%"=="\" (goto tTarget2) else (goto endTarget2)
:tTarget2
set target=%target:~0,-1%
goto target2
:endTarget2
::���������ȥ��ĩβ����Ŀո�" "
:target3
if "%target:~-1,1%"==" " (goto tTarget3) else (goto endTarget3)
:tTarget3
set target=%target:~0,-1%
goto target3
:endTarget3

::��ͬ��Ŀ¼�¸���ԴĿ¼�ṹ
xcopy %Source% %target%  /C /K /T /E /Y /I

::��ȡԴ�ļ��е�Ŀ¼,��ȥ���ļ�����
set sourDir=%Source%
:sourDir
if "%sourDir:~-1,1%"=="\" (goto endsourDir) else (goto tsourDir)
:tsourDir
set sourDir=%sourDir:~0,-1%
goto sourDir
:endsourDir

::  echo Դ�ļ���Ŀ¼: __%sourDir%__
::  pause

::��ȡԴ�ļ�������
set sourceName=%source%
:sourceName
if "%source%"=="%sourDir%%sourceName%" (goto endSourceName) else (goto tSourceName)
:tSourceName
set sourceName=%sourceName:~1%
goto sourceName
:endSourceName

::  echo Դ�ļ�������: __%SourceName%__
::  pause


  
::��ȡĿ���ļ��е�Ŀ¼
set targetDir=%target%
:targetDir
if "%targetDir:~-1,1%"=="\" (goto endTargetDir) else (goto tTargetDir)
:tTargetDir
set targetDir=%targetDir:~0,-1%
goto targetDir
:endTargetDir

::  echo Ŀ���ļ���Ŀ¼: __%targetDir%__
::  pause

::��ȡĿ���ļ�������
set targetName=%target%
:targetName
if "%target%"=="%targetDir%%targetName%" (goto endTargetName) else (goto tTargetName)
:tTargetName
set targetName=%targetName:~1%
goto targetName
:endTargetName

::  echo Ŀ���ļ�������: __%targetName%__
::  pause

::echo Դ�ļ���Ŀ¼: __%sourDir%__
::echo Դ�ļ�������: __%sourceName%__
::echo Ŀ���ļ���Ŀ¼: __%targetDir%__
::echo Ŀ���ļ�������: __%targetName%__

:: ���� /R ��ʾ��Ҫ�������ļ���,ȥ����ʾ���������ļ���
:: %%f ��һ������,�����ڵ�����,�����������ֻ����һ����ĸ���,ǰ�����%%
:: ��������ͨ���,����ָ����׺��,*.*��ʾ�����ļ�
for /R %Source% %%f in (*.*) do ( 
call:fileStart %%f
)

::��ȡĿ���ļ����·��0(ȥ��Դ�ļ���Ŀ¼)
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
::  echo ȥ��Դ�ļ���Ŀ¼: __%file%__
::  pause

::��ȡĿ���ļ����·��1(�滻Դ�ļ���Ŀ¼����ΪĿ���ļ�����targetName)
set SourceNameBk=%SourceName%
:file2
if "%SourceNameBk%"=="" (goto endFile2) else (goto tFile2)
:tFile2
set SourceNameBk=%SourceNameBk:~1%
set file=%file:~1%
goto file2
:endFile2
set file=%targetName%%file%

::  echo �滻Դ�ļ���Ŀ¼��ΪĿ��: __%filelink%__
::  pause

::��ȡĿ���ļ����·��2(�������·��)
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

::��ȡ���տ�ݷ�ʽ��ȫ·��
::�˴�����ֱ������,���滻��׺
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

::  echo GET����Դ�ļ����·��: __%fileDir%__
::  echo GET���տ�ݷ�ʽ·��__: __%filelink%__
::  pause

:setVbsName
set vbsName=makelnk%random%.vbs
if exist %vbsName% ( goto setVbsName ) else ( goto endSetVbsName )
:endSetVbsName

:: ���ɵ���vbs������ݷ�ʽ
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