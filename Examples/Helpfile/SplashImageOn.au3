$destination = @Systemdir & "\oobe\images\mslogo.jpg"

SplashImageOn("Splash Screen", $destination,250,50)
Sleep(3000)
SplashOff()