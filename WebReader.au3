#include <IE.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>


Local $addresses[40]=["https://archive.org/stream/abbeychurchesofb00perkuoft/abbeychurchesofb00perkuoft_djvu.txt","https://archive.org/stream/apicturesquegui00lapogoog/apicturesquegui00lapogoog_djvu.txt","https://archive.org/stream/somersetdioceseb00hunt/somersetdioceseb00hunt_djvu.txt","https://archive.org/stream/bathwells00salmrich/bathwells00salmrich_djvu.txt","https://archive.org/stream/bathwellssketchb00andrrich/bathwellssketchb00andrrich_djvu.txt","https://archive.org/stream/bathbristolwithc00britrich/bathbristolwithc00britrich_djvu.txt","https://archive.org/stream/historyantiqutit01colluoft/historyantiqutit01colluoft_djvu.txt","https://archive.org/stream/historyantiqutit02colluoft/historyantiqutit02colluoft_djvu.txt","https://archive.org/stream/historyantiqutit03colluoft/historyantiqutit03colluoft_djvu.txt","https://archive.org/stream/mediaevalnunneri00hugouoft/mediaevalnunneri00hugouoft_djvu.txt","https://archive.org/stream/ecclesiasticaldo00huntrich/ecclesiasticaldo00huntrich_djvu.txt","https://archive.org/stream/walksthroughbath00egan/walksthroughbath00egan_djvu.txt","https://archive.org/stream/streetloreofbath00peaciala/streetloreofbath00peaciala_djvu.txt","https://archive.org/stream/bathunderbeaunas00melvuoft/bathunderbeaunas00melvuoft_djvu.txt","https://archive.org/stream/hotspringsofbath00hattuoft/hotspringsofbath00hattuoft_djvu.txt","https://archive.org/stream/bishopsschoolpri00bath/bishopsschoolpri00bath_djvu.txt","https://archive.org/stream/bathsatiricalnov01brow/bathsatiricalnov01brow_djvu.txt","https://archive.org/stream/bathsatiricalnov02brow/bathsatiricalnov02brow_djvu.txt","https://archive.org/stream/bathsatiricalnov03brow/bathsatiricalnov03brow_djvu.txt","https://archive.org/stream/historichousesin01peaciala/historichousesin01peaciala_djvu.txt","https://archive.org/stream/historichousesin02peaciala/historichousesin02peaciala_djvu.txt","https://archive.org/stream/connectionofbath00huntrich/connectionofbath00huntrich_djvu.txt","https://archive.org/stream/historyofroyalmi00falc/historyofroyalmi00falc_djvu.txt","https://archive.org/stream/bathroadhistoryf00harp/bathroadhistoryf00harp_djvu.txt","https://archive.org/stream/sermonspreachedi00wils/sermonspreachedi00wils_djvu.txt","https://archive.org/stream/cu31924001093610/cu31924001093610_djvu.txt","https://archive.org/stream/cu31924028089708/cu31924028089708_djvu.txt","https://archive.org/stream/ancientdeedsbelo00corp/ancientdeedsbelo00corp_djvu.txt","https://archive.org/stream/biographicalsket00murciala/biographicalsket00murciala_djvu.txt","https://archive.org/stream/registersabbeyc01jewegoog/registersabbeyc01jewegoog_djvu.txt","https://archive.org/stream/registersabbeyc00jewegoog/registersabbeyc00jewegoog_djvu.txt","https://archive.org/stream/sermonspreacheda00rand/sermonspreacheda00rand_djvu.txt","https://archive.org/stream/livesofbishopsof00cass/livesofbishopsof00cass_djvu.txt","https://archive.org/stream/newbathguideorme00anstuoft/newbathguideorme00anstuoft_djvu.txt","https://archive.org/stream/medicalguidetoho00bathuoft/medicalguidetoho00bathuoft_djvu.txt","https://archive.org/stream/bathashealthreso00bathuoft/bathashealthreso00bathuoft_djvu.txt","https://archive.org/stream/historyantiquiti00brit_1/historyantiquiti00brit_1_djvu.txt","https://archive.org/stream/lifetimesofralph00peaciala/lifetimesofralph00peaciala_djvu.txt","https://archive.org/stream/popularguidetous00kerruoft/popularguidetous00kerruoft_djvu.txt"]

Local $numerals[10]=["I"&@CRLF,@CRLF&"II"&@CRLF,@CRLF&"III"&@CRLF,@CRLF&"IV"&@CRLF,@CRLF&"V"&@CRLF,@CRLF&"VI"&@CRLF,@CRLF&"VII"&@CRLF]
$finalmessage=""
$nextWord=""
$message=""
$i=0

startStory()
While($i<5)
   continueStory()
   $i+=1
WEnd
GUICreate("BathInBooks",800,600)
GUISetState(@SW_SHOW)
GUICtrlCreateEdit($finalmessage, 20, 20, 760, 560,$ES_READONLY)
While 1
   $msg =GUIGetMsg(1)
   If $msg[0]==$GUI_EVENT_CLOSE Then
	  ExitLoop
   EndIf
WEnd

Func startStory()
   $oIE = _IECreate($addresses[Random(0,UBound($addresses)-1,1)])
   $divs = _IETagNameGetCollection($oIE, "pre")

   For $div In $divs
	  $message=StringMid($div.innerText, Random(1000, 100000, 1), 200)
	  $message=StringTrimLeft($message,StringInStr($message," "))
	  $message=StringTrimRight($message,StringInStr(StringReverse($message)," "))
   Next

   $nextWord=StringTrimLeft($message,StringLen($message)-StringInStr(StringReverse($message)," "))
   _IEQuit($oIE)
   $message=StringTrimRight($message,StringLen($nextWord))
   $finalmessage=$finalmessage&$numerals[$i]&$message
EndFunc

Func continueStory()
   $oIE = _IECreate($addresses[Random(0,UBound($addresses)-1,1)])
   $divs = _IETagNameGetCollection($oIE, "pre")

   For $div In $divs
	  $divmessage=StringTrimLeft($div.innerText,1000)
   Next
   If (StringInStr($div.innerText,$nextWord)==-1) Then
		 $message=StringMid($divmessage,StringInStr($div.innerText,$nextWord), 200)
		 $message=StringTrimRight($message,StringInStr(StringReverse($message)," "))
		 _IEQuit($oIE)
		 $nextWord=StringTrimLeft($message,StringLen($message)-StringInStr(StringReverse($message)," "))
		 $message=StringTrimRight($message,StringLen($nextWord))
		 $finalmessage=$finalmessage&$numerals[$i]&$message
	  Else
		 _IEQuit($oIE)
		 startStory()
	  EndIf
EndFunc