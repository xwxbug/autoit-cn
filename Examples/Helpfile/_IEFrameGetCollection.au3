
 
   
相关  _IEIsFrameSet , _IEFrameGetObjByName  
   
示例  
 ; ******************************************************* 
 ; 示例 - 打开框架集示例, 获取框架集 
 ; ******************************************************* 
 #include <IE.au3> 
 $oIE = _IE_Example ( " frameset " ) 
 $oFrames = _IEFrameGetCollection ( $oIE ) 
 $iNumFrames = @extended 
 For $i = 0  to ( $iNumFrames - 1 ) 
   $oFrame = _IEFrameGetCollection ( $oIE , $i ) 
   MsgBox ( 0 , " Frame Info > ", _IEPropertyGet ( $oFrame , " locationurl " )) 
 Next 
