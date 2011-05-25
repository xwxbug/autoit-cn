;图片路径
Local $destination = "..\GUI\mslogo.jpg"

SplashImageOn("Splash Screen", $destination,250,50,-1,-1,1)	;使用无标题细边框
Sleep(3000)
SplashOff()