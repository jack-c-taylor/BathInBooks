#include <IE.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <Array.au3>
#include <File.au3>


Local $addresses[40]=["https://archive.org/stream/abbeychurchesofb00perkuoft/abbeychurchesofb00perkuoft_djvu.txt","https://archive.org/stream/apicturesquegui00lapogoog/apicturesquegui00lapogoog_djvu.txt","https://archive.org/stream/somersetdioceseb00hunt/somersetdioceseb00hunt_djvu.txt","https://archive.org/stream/bathwells00salmrich/bathwells00salmrich_djvu.txt","https://archive.org/stream/bathwellssketchb00andrrich/bathwellssketchb00andrrich_djvu.txt","https://archive.org/stream/bathbristolwithc00britrich/bathbristolwithc00britrich_djvu.txt","https://archive.org/stream/historyantiqutit01colluoft/historyantiqutit01colluoft_djvu.txt","https://archive.org/stream/historyantiqutit02colluoft/historyantiqutit02colluoft_djvu.txt","https://archive.org/stream/historyantiqutit03colluoft/historyantiqutit03colluoft_djvu.txt","https://archive.org/stream/mediaevalnunneri00hugouoft/mediaevalnunneri00hugouoft_djvu.txt","https://archive.org/stream/ecclesiasticaldo00huntrich/ecclesiasticaldo00huntrich_djvu.txt","https://archive.org/stream/walksthroughbath00egan/walksthroughbath00egan_djvu.txt","https://archive.org/stream/streetloreofbath00peaciala/streetloreofbath00peaciala_djvu.txt","https://archive.org/stream/bathunderbeaunas00melvuoft/bathunderbeaunas00melvuoft_djvu.txt","https://archive.org/stream/hotspringsofbath00hattuoft/hotspringsofbath00hattuoft_djvu.txt","https://archive.org/stream/bishopsschoolpri00bath/bishopsschoolpri00bath_djvu.txt","https://archive.org/stream/bathsatiricalnov01brow/bathsatiricalnov01brow_djvu.txt","https://archive.org/stream/bathsatiricalnov02brow/bathsatiricalnov02brow_djvu.txt","https://archive.org/stream/bathsatiricalnov03brow/bathsatiricalnov03brow_djvu.txt","https://archive.org/stream/historichousesin01peaciala/historichousesin01peaciala_djvu.txt","https://archive.org/stream/historichousesin02peaciala/historichousesin02peaciala_djvu.txt","https://archive.org/stream/connectionofbath00huntrich/connectionofbath00huntrich_djvu.txt","https://archive.org/stream/historyofroyalmi00falc/historyofroyalmi00falc_djvu.txt","https://archive.org/stream/bathroadhistoryf00harp/bathroadhistoryf00harp_djvu.txt","https://archive.org/stream/sermonspreachedi00wils/sermonspreachedi00wils_djvu.txt","https://archive.org/stream/cu31924001093610/cu31924001093610_djvu.txt","https://archive.org/stream/cu31924028089708/cu31924028089708_djvu.txt","https://archive.org/stream/ancientdeedsbelo00corp/ancientdeedsbelo00corp_djvu.txt","https://archive.org/stream/biographicalsket00murciala/biographicalsket00murciala_djvu.txt","https://archive.org/stream/registersabbeyc01jewegoog/registersabbeyc01jewegoog_djvu.txt","https://archive.org/stream/registersabbeyc00jewegoog/registersabbeyc00jewegoog_djvu.txt","https://archive.org/stream/sermonspreacheda00rand/sermonspreacheda00rand_djvu.txt","https://archive.org/stream/livesofbishopsof00cass/livesofbishopsof00cass_djvu.txt","https://archive.org/stream/newbathguideorme00anstuoft/newbathguideorme00anstuoft_djvu.txt","https://archive.org/stream/medicalguidetoho00bathuoft/medicalguidetoho00bathuoft_djvu.txt","https://archive.org/stream/bathashealthreso00bathuoft/bathashealthreso00bathuoft_djvu.txt","https://archive.org/stream/historyantiquiti00brit_1/historyantiquiti00brit_1_djvu.txt","https://archive.org/stream/lifetimesofralph00peaciala/lifetimesofralph00peaciala_djvu.txt","https://archive.org/stream/popularguidetous00kerruoft/popularguidetous00kerruoft_djvu.txt"]

Local $numerals[10]=["I"&@CRLF,@CRLF&"II"&@CRLF,@CRLF&"III"&@CRLF,@CRLF&"IV"&@CRLF,@CRLF&"V"&@CRLF,@CRLF&"VI"&@CRLF,@CRLF&"VII"&@CRLF]
$finalmessage=""
$nextWord=""
$message=""
$i=0
$outline=""
$outline2=""

startStory()
While($i<5)
   continueStory()
   $i+=1
WEnd
analysis()
GUICreate("BathInBooks",1200,600)
GUISetState(@SW_SHOW)
GUICtrlCreateEdit($finalmessage, 20, 20, 760, 560)
GUICtrlCreateEdit($outline, 800, 20, 300, 360)
GUICtrlCreateEdit($outline2, 800, 400, 300, 160)
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
		 $finalmessage=$finalmessage&$message
	  Else
		 _IEQuit($oIE)
		 startStory()
	  EndIf
   EndFunc

Func analysis()
   $outline=""
   $outline2=""
   $long=0
   $short=0
   $a=StringReplace($finalmessage, ",","")
   $lines=StringSplit($a,@CRLF)
   $line=1
   Do
	  $words=StringSplit($lines[$line], " ")
	  $word=1
	  ;Alliteration and repetition
	  if UBound($words)>2 Then
	  Do
		 If StringCompare(StringMid($words[$word],1,1),StringMid($words[$word+1],1,1))=0 and not $words[$word]="" Then
			$outline=$outline&"Alliteration on line "&($line+1)/2&"."&@CRLF
		 EndIf

		 If StringInStr( $lines[$line],$words[$word],0,2) Then
			$outline=$outline&"Repitition on line "&($line+1)/2&":"&$words[$word]&@CRLF
			ExitLoop
		 EndIf

		 $word=$word+1
	  Until $word>=Ubound($words)-1
	  $word=1
	  if UBound($words)>4 Then
	  Do
		 If StringCompare(StringMid($words[$word],1,1),StringMid($words[$word+2],1,1))=0 and not $words[$word]="" Then ;Imperfect-won't do last word
			$outline=$outline&"Alliteration on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 $word=$word+1
	  Until $word>=Ubound($words)-3
   EndIf
   ;Word length
   Do
	  If StringLen($words[$word])>5 Then
		 $long=$long+1
	  Else
		 $short=$short+1
	  EndIf
	  $word=$word+1
   Until $word>=Ubound($words)-1
EndIf
   ;Similes
   If StringInStr($lines[$line], "like a") or StringInStr($lines[$line], "like the") Then
		 $outline=$outline&"Simile on line "&($line+1)/2&"."&@CRLF
   EndIf

	  ;Syllable count
	  $syllable=1
	  $letter=1
	  $vowel=StringSplit("a e i o u"," ")
	  Do
		 If not (_ArraySearch($vowel,StringMid($lines[$line],$letter,1))=-1)  Then
			$syllable+=1
		 EndIf
		 $letter=$letter+1
	  Until $letter>=StringLen($lines[$line])
	  $syl="monometer"
	  If $syllable>3 Then
		 $syl="dimeter"
	  EndIf
	  If $syllable>5 Then
		 $syl="trimeter"
	  EndIf
	  If $syllable>7 Then
		 $syl="tetrameter"
	  EndIf
	  If $syllable>9 Then
		 $syl="pentameter"
	  EndIf
	  If $syllable>11 Then
		 $syl="hexameter"
	  EndIf
	  If not $lines[$line]="" Then
	  $outline=$outline&"Line "&($line+1)/2&" may be written in "&$syl&"."&@CRLF
   EndIf
   ;Anaphora
   $fragment=""
   If UBound($lines)>$line+2 Then
	  $words=StringSplit($lines[$line], " ")
	  $words2=StringSplit($lines[$line+2], " ")
	  $word=1
	  If UBound($words)>1 and UBound($words2)>1 Then

	  Do
		 $a=$words[$word]
		 $b=$words2[$word]
		 If $a=$b Then
		 $fragment=$fragment&$words[$word]&" "
	  Else
		 ExitLoop
	  EndIf
		 $word=$word+1
	  Until $word=UBound($words) or $word=UBound($words2)

	  EndIf
	  If not ($fragment="" or $fragment=" ") Then
		 $outline=$outline&"Anaphora on line"&($line+1)/2&":"&$fragment&@CRLF
	  EndIf
	  $word=0
   EndIf
	  $line=$line+1

Until $line>=Ubound($lines)
If $long/($long+$short)>0.5 Then
   $outline=$outline&"This poem is mostly polysyllabic."&@CRLF
   $outline2=$outline2&"This poem is mostly polysyllabic."&@CRLF
Else
   $outline=$outline&"This poem contains many short words."&@CRLF
   $outline2=$outline2&"This poem contains many short words."&@CRLF
EndIf

;Perspective
If StringInStr($finalmessage, "I ",1) Then
   $outline=$outline&"Contains features of a 1st person narrative."&@CRLF
   $outline2= $outline2&"This contains features of a first-person narrative. Things to consider include reliability and the feelings the narrator is trying to elicit."&@CRLF
EndIf
If StringInStr($finalmessage, " he ") or StringInStr($finalmessage, "she ") Then
   $outline=$outline&"Contains features of a 3rd person narrative."&@CRLF
   $outline2= $outline2&"This contains features of a third-person narrative. Things to consider include which characters are focused on and whether their thoughts are described."&@CRLF
EndIf

;Positive vs negative and themes
   $a=StringReplace($finalmessage, ",","")
   $lines=StringSplit($a,@CRLF)
   $line=1
   $pos=0
   $neg=0
   $death=0
   $isolation=0
   $religion=0
   $love=0
   $child=0
   $guilt=0
   $red=0
   $white=0
   $nature=0
   $file = FileOpen("settings.txt", 0)
	  $poswords=StringSplit(FileReadLine($file,1), " ")
	  $negwords=StringSplit(FileReadLine($file,2), " ")
	  $deathwords=StringSplit(FileReadLine($file,3), " ")
	  $isolationwords=StringSplit(FileReadLine($file,4), " ")
	  $religionwords=StringSplit(FileReadLine($file,5), " ")
	  $lovewords=StringSplit(FileReadLine($file,6), " ")
	  $childwords=StringSplit(FileReadLine($file,7), " ")
	  $guiltwords=StringSplit(FileReadLine($file,8), " ")
	  $redwords=StringSplit(FileReadLine($file,9), " ")
	  $whitewords=StringSplit(FileReadLine($file,10), " ")
	  $naturewords=StringSplit(FileReadLine($file,11), " ")
   FileClose($file)
   $posfin=""
   $negfin=""
   Do
	  $words=StringSplit($lines[$line], " ")
	  $word=1
	  Do
		 If not (_ArraySearch($poswords,$words[$word])=-1) Then
			$pos=$pos+1
			$outline=$outline&"Positive term '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
			If StringInStr($posfin,$words[$word])=0 Then
			$posfin=$posfin&$words[$word]&", "
			EndIf
		 ElseIf not (_ArraySearch($negwords,$words[$word])=-1) Then
			$neg=$neg+1
			$outline=$outline&"Negative term '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
			If StringInStr($negfin,$words[$word])=0 Then
			$negfin=$negfin&$words[$word]&", "
			EndIf
		 EndIf
		 If not (_ArraySearch($deathwords,$words[$word])=-1) Then
			$death=$death+1
			$outline=$outline&"Reference to death with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($isolationwords,$words[$word])=-1) Then
			$isolation=$isolation+1
			$outline=$outline&"Reference to isolation with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($religionwords,$words[$word])=-1) Then
			$religion=$religion+1
			$outline=$outline&"Reference to religion with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($lovewords,$words[$word])=-1) Then
			$love=$love+1
			$outline=$outline&"Reference to love with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($childwords,$words[$word])=-1) Then
			$child=$child+1
			$outline=$outline&"Reference to children with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($guiltwords,$words[$word])=-1) Then
			$guilt=$guilt+1
			$outline=$outline&"Reference to sin with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($redwords,$words[$word])=-1) Then
			$red=$red+1
			$outline=$outline&"Reference to red with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($whitewords,$words[$word])=-1) Then
			$white=$white+1
			$outline=$outline&"Reference to white with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 If not (_ArraySearch($naturewords,$words[$word])=-1) Then
			$nature=$nature+1
			$outline=$outline&"Reference to nature with '"&$words[$word]&"' on line "&($line+1)/2&"."&@CRLF
		 EndIf
		 $word=$word+1
	  Until $word>=Ubound($words)
	  $line=$line+1
   Until $line>=Ubound($lines)
   $lineint=(UBound($lines)/6)
   If $pos>$neg and $pos>$lineint Then
		 $outline2=$outline2&"There are many positive words such as " &$posfin&@CRLF
	  EndIf
   If $neg>$pos and $neg>$lineint Then
		 $outline2=$outline2&"There are many negative words such as " &$negfin&@CRLF
	  EndIf
	  If $isolation>$lineint Then
	  $outline2=$outline2&"Isolation is a theme." &@CRLF
   EndIf
   If $death>$lineint Then
	  $outline2=$outline2&"Death is a theme." &@CRLF
   EndIf
   If $religion>$lineint Then
	  $outline2=$outline2&"Religion is a theme." &@CRLF
   EndIf
   If $love>$lineint Then
	  $outline2=$outline2&"Love is a theme." &@CRLF
   EndIf
   If $child>$lineint Then
	  $outline2=$outline2&"Children are a theme." &@CRLF
   EndIf
   If $guilt>$lineint Then
	  $outline2=$outline2&"Sin is a theme." &@CRLF
   EndIf
   If $red>$lineint Then
	  $outline2=$outline2&"The colour red is present throughout, possibly to represent passion or violence." &@CRLF
   EndIf
   If $white>$lineint Then
	  $outline2=$outline2&"The colour white is present throughout, possibly to represent innocence." &@CRLF
   EndIf
   If $nature>$lineint Then
	  $outline2=$outline2&"Nature is a theme." &@CRLF
   EndIf
EndFunc