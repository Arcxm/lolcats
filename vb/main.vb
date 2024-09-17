Imports System

Module lolcat
	Const Esc As Char = ChrW(27)
	Const ColorReset As String = Esc + "[0m"
	Const Freq As Double = 0.1

	Structure RGB
		Public r As Byte
		Public g As Byte
		Public b As Byte
	
		Public Sub New(ByVal r As Byte, ByVal g As Byte, ByVal b As Byte)
			Me.r = r
			Me.g = g
			Me.b = b
		End Sub

		Public Shared Function Rainbow(ByVal frequency As Double, ByVal i As Integer) As RGB
			Dim r As Byte = Math.Sin(frequency * i) * 127 + 128
			Dim g As Byte = Math.Sin(frequency * i + 2 * Math.PI / 3) * 127 + 128
			Dim b As Byte = Math.Sin(frequency * i + 4 * Math.PI / 3) * 127 + 128

			Return new RGB(r, g, b)
		End Function

		Public Function EscapeSequence() As String
			Return $"{Esc}[38;2;{Me.r};{Me.g};{Me.b}m"
		End Function
	End Structure

	Sub PutcWithRGB(ByVal c As Char, ByVal color As RGB)
		Console.Write($"{color.EscapeSequence()}{c}{ColorReset}")
	End Sub

	Sub Main(args As String())
		' Check if at least one command line argument was provided
		If args.Length > 0 Then
			Dim input As String = args(0)

			For i As Integer = 0 To input.Length - 1
				PutcWithRGB(input(i), RGB.Rainbow(Freq, i))
			Next i
		End If
	End Sub
End Module