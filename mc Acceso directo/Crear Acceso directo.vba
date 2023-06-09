'Public mcSetWindowsFileShortcut
'-----------------------------------------------------------------------------------------------------------------------------------------------
' Fuente            : https://access-global.net/crear-un-acceso-directo-personalizado-en-el-escritorio
'-----------------------------------------------------------------------------------------------------------------------------------------------
' Título            : Crear un acceso directo personalizado en el escritorio
' Autor             : Rafael Andrada .:McPegasus:. | BeeSoftware
' Actualizado       : 21/04/2019
' Propósito         : Crear un acceso directo personalizado en el escritorio
' Retorno           : Si no se produce ningún error se obtiene un acceso directo en el escritorio
' Argumento/s       : La sintaxis del procedimiento o función consta de/los siguiente/s argumento/s:
'                     Parte                 Modo           Descripción
'-----------------------------------------------------------------------------------------------------------------------------------------------
'                     strFileName               Obligatorio             El valor String especifica el nombre del programa FrontEnd a abrir.
'                     strArguments              Obligatorio
'                     NOMBRE_DEL_ARGUMENTO       Obligatorio/Opcional    El valor String especifica el SUSTITUIR_POR_UNA_BREVE_DESCRIPCIÓN_DEL_PARÁMETRO
'-----------------------------------------------------------------------------------------------------------------------------------------------
' Sobre Referenciar : El referenciar una librería externa nos permite seleccionar los objetos de otra aplicación que se desea que estén disponibles en nuestro código.
'                     También acceder a sus métodos utilizar las constantes.
'                     En caso de ser opcional podemos seguir utilizándolo aunque las constantes hay que sustituirlas por su valor, normalmente numérico.
'                     Más información: https://support.microsoft.com/es-es/office/add-object-libraries-to-your-visual-basic-project-ed28a713-5401-41b0-90ed-b368f9ae2513
' Referencia        : Microsoft Windows Common Controls 6.0 (SP6) (c:\Windows\SysWOW64\MSCOMCTL.ocx)/>
' Referencia        : Opcional. Windows Script Host Object Model (c:\Windows\system32\wshom.ocx)/>
' Referencia        : Opcional. Microsoft Office 16.0 Object Library (c:\Program Files (x86)\Common Files\Microsoft Shared\OFFICE16\...)/>
'-----------------------------------------------------------------------------------------------------------------------------------------------
'Test:              : Para adaptar este código en tu aplicación puedes basarte en este procedimiento test.  todo el procedimiento desde el Sub hasta el End Sub
'                     al portapapeles y pega en el editor de VBA de tu aplicación MS Access. Descomentar todas las líneas que nos interese (se aconseja seleccionar
'                     todas las líneas del ejemplo y utilizar el botón 'Bloque sin comentarios' de la barra de herramientas 'Edición').
'                     Pulsar F5 para ver su funcionamiento.
'-----------------------------------------------------------------------------------------------------------------------------------------------
'Test:              : Para adaptar este código en tu aplicación puedes basarte en este procedimiento test. Copiar el bloque siguiente al
'                     portapapeles y pega en el editor de VBA. Descomentar la línea que nos interese y pulsar F5 para ver su funcionamiento.
'
'Sub mcSetWindowsFileShortcut_test()
'   En este procedimiento mcSetWindowsFileShortcut_test hay varios ejemplos de cómo conseguir rápidamente un acceso directo.
'
'End Sub
'-----------------------------------------------------------------------------------------------------------------------------------------------
'<mcKB>
'<Título ES= Crear un acceso directo personalizado en el escritorio./>
'<Grupo= Archivos/>
'<Subgrupo=/>
'
'<Autor= Rafael .:McPegasus:./>
'<Contacto= rafael@mcpegasus.net, www.mcpegasus.net/>
'
'OBSERVACIONES INTERNAS PARA DEVELOPER (visibles sólo aquí): Sólo se guarda en tblmcKB este primer grupo donde se indica la versión <Versión= 01/>, el grupo de <Revisión = nn/> no.
'<Versión= 01/><Fecha creación= 21/04/2019/>
'<Descripción= Creación de la función./>
'
'<Propósito= Crear un acceso directo personalizado en el escritorio./>
'
'<Retorno= Si no se produce ningún error se obtiene un acceso directo en el escritorio./>
'
'<ExpresionesDeBusqueda= Acceso directo, link, vínculo./>
'
'<Referencia= Opcional: Windows Script Host Object Model (c:\Windows\system32\wshom.ocx). El código está escrito en enlace tardío, por lo que no se requiere ninguna referencia./>/>
'
'<Enum= mcEnmOpeningMode./>
'
'<Más información= https://docs.microsoft.com/es-es/troubleshoot/windows-client/admin-development/create-desktop-shortcut-with-wsh/>
'
'La SINTAXIS de la instrucción consta de los siguientes argumentos con nombre:
'<Sintaxis= strFileName, strShortcutName, strWorkingDirectory, [strArguments], [ strHotkey ], [ strDescription ], [ strIconLocation ], [ bytWindowsStyle ]>
'
'   <Parte= strShortcutName/>
'       <Modo= Obligatorio/>
'       <Descripción= El valor String especifica el nombre del acceso directo, el texto que se visualiza junto a la imagen./>
'
'   <Parte= strWorkingDirectory/>
'       <Modo= Obligatorio/>
'       <Descripción= El valor String especifica la ruta que se indica en Iniciar en, también se usa para configurar TargetPath. No hay que incluir el nombre del archivo a abrir, de este se informa en el parámetro strFileName./>
'
'   <Parte= strFileName/>
'       <Modo= Obligatorio/>
'       <Descripción= El valor String especifica el nombre del programa FrontEnd a abrir./>
'
'   <Parte= [ strArguments ]/>
'       <Modo= Optional/>
'       <Descripción= El valor String especifica el valor de la segunda parte a indicar en la propiedad TargetPath. Primero va strWorkingDirectory & strFileName y a continuación este parámetro./>
'
'   <Parte= [ strHotkey ]/>
'       <Modo= Opcional/>
'       <Descripción= El valor String especifica sólo la letra para abrir la aplicación con la combinación de teclas Alt + Gr./>
'
'   <Parte= [ strDescription ]/>
'       <Modo= Opcional/>
'       <Descripción= El valor String especifica la descripción de lo que realiza el acceso directo. Es el texto informativo que se nos muestra al poner el ratón encima del acceso directo./>
'
'   <Parte= [ strIconLocation ]/>
'       <Modo= Opcional/>
'       <Descripción= El valor String especifica la ruta completa, directorio y nombre de archivo con extensión del icono./>
'
'   <Parte= [ bytWindowsStyle ]/>
'       <Modo= Opcional/>
'       <Descripción= El valor mcEnmOpeningMode especifica el modo en el que se abre el programa, maximizado, minimizado o normal (restaurado)./>
'
'</Sintaxis>
'-----------------------------------------------------------------------------------------------------------------------------------------------
'Test:              : Para adaptar este código en tu aplicación puedes basarte en este procedimiento test. Copiar el bloque siguiente al
'                     portapapeles y pega en el editor de VBA. Descomentar la línea que nos interese y pulsar F5 para ver su funcionamiento.
'
'Sub mcSetWindowsFileShortcut_test()
'   En este procedimiento hay varios ejemplos de cómo conseguir rápidamente un acceso directo.
'
'End Sub
'-----------------------------------------------------------------------------------------------------------------------------------------------
'</mcKB>
Dim wshShell                                   As Object                          'Object/IWshShell3
Dim wshShortcut                                As Object                          'Object/IWshShortcut
'    Dim wshShell                                    As IWshShell3
'    Dim wshShortcut                                 As IWshShortcut
Dim strFolderShortcut                           As String
Dim strTargetPath                               As String
Set wshShell = CreateObject("WScript.Shell")
strFolderShortcut = wshShell.SpecialFolders("Desktop") & "\" & strShortcutName & ".lnk"
'Eliminar siempre, es posible que se haya modificado algún parámetro.
If Not Dir(strFolderShortcut, vbNormal) = "" Then
Kill (strFolderShortcut)
End If
strTargetPath = strWorkingDirectory & IIf(Right(strWorkingDirectory, 1) = "\", Null, "\") & strFileName
If Not (Left(strTargetPath, 1) = "%") And Dir(strTargetPath, vbArchive) = "" Then
MsgBox "Se está intentando crear un acceso directo a un programa que no existe en la ruta " & strTargetPath & "." & vbCrLf & vbCrLf & "No se puede continuar con el proceso.", vbCritical
Else
Set wshShell = CreateObject("WScript.Shell")
Set wshShortcut = wshShell.CreateShortcut(strFolderShortcut)                    'Objeto que nos permite crear el acceso directo.
With wshShortcut
.TargetPath = strTargetPath                                                 'Destino.
If Not strArguments = "" Then .Arguments = strArguments
If Not strIconLocation = "" Then .IconLocation = strIconLocation            'Ruta y nombre del icono.
.WorkingDirectory = strWorkingDirectory                                     'Iniciar en.
.WindowStyle = IIf(bytWindowsStyle = 0, Maximized, bytWindowsStyle)         'Ejecutar. 3=Maximized 7=Minimized  4=Normal
If Not strDescription = "" Then .Description = strDescription
If Not strHotkey = "" Then
If Asc(strHotkey) >= 65 And Asc(strHotkey) <= 90 Or Asc(strHotkey) >= 97 And Asc(strHotkey) <= 120 Then
.Hotkey = "ALT+CTRL+" & strHotkey
End If
End If
.Save
End With
End If
Set wshShortcut = Nothing
Set wshShell = Nothing
End Sub
Sub mcSetWindowsFileShortcut_test()
'<mcKB>
'<Grupo= Test/>
'<Descripción= Varios ejemplos de como crear un acceso directo personalizado en el escritorio./>
'</mcKB>
Dim bytSelectExample                            As Byte
Dim bytWindowsStyle                             As mcEnmOpeningMode
Dim strArguments                                As String
Dim strDescription                              As String
Dim strHotkey                                   As String
Dim strIconLocation                             As String
Dim strFileName                                 As String
Dim strShortcutName                             As String
Dim strWorkingDirectory                         As String
bytSelectExample = 1
Select Case bytSelectExample
Case 1              'Ejemplo de como crear un acceso directo del Bloc de notas, notepad.
strShortcutName = "Bloc de notas"                   'Nombre del acceso directo.
strWorkingDirectory = "%windir%\system32"           'Directorio donde está alojado el programa. Sólo la ruta.
strFileName = "notepad.exe"                         'Nombre del programa. Sólo el nombre con la extensión.
'Si no tenemos niguno para realizar el test, podemos descargar el ico de Access-Global desde https://access-global.net/wp-content/uploads/2022/02/Favicon_Access_global.ico
strIconLocation = strWorkingDirectory & IIf(Right(strWorkingDirectory, 1) = "\", Null, "\") & strFileName   'Ruta completa, directorio y nombre de archivo con extensión del icono.
strHotkey = "N"                                     'Sólo la letra para abrir la aplicación con la combinación de teclas Alt + Gr.
strDescription = "Mi primer acceso directo."        'Breve descripción de lo que realiza el acceso directo. Es el texto informativo que se nos muestra al poner el ratón encima del acceso directo.
bytWindowsStyle = Minimized                         'Modo en el que se abre el programa, maximizado, minimizado o normal (restaurado).
Case 2              'Como crear un acceso directo a una aplicación propia (FrontEnd).
strShortcutName = "appSubastas"
strWorkingDirectory = "c:\Bee-Software\bee-Subastas"
strFileName = "appSubastas.accde"
strIconLocation = "c:\ProgramData\HrafnaFloki\appIco_BeeSubastas.ico"
Case 3              'Como crear un acceso directo con argumento. Enlazamos MSACCESS.EXE con una aplicación propia (FrontEnd).
strShortcutName = "appBeerp"
strWorkingDirectory = SysCmd(acSysCmdAccessDir)         'O C:\Program Files (x86)\Microsoft Office\root\Office16.
strFileName = "MSACCESS.EXE"
strArguments = "c:\Bee-Software\Bee-Beerp\appBeerp.accde"
strIconLocation = "c:\ProgramData\HrafnaFloki\app-ico_appBeerp.ico"
Case 4              'Como crear un acceso directo personalizado con argumento. Enlazamos MSACCESS.EXE con una aplicación propia (FrontEnd) que además le pasamos un argumento. Rizando el rizo.
strShortcutName = "appBeeIT"
strWorkingDirectory = SysCmd(acSysCmdAccessDir)         'O C:\Program Files (x86)\Microsoft Office\root\Office16.
strFileName = "MSACCESS.EXE"
'Al utilizar una aplicación lanzadera (que está en un servidor) que copia el FrontEnd al equipo usuario, le paso un parámetro (después del /cmd) con el nombre de la aplicación a abrir.
strArguments = "l:\apps\appBeeLanz.accde /cmd " & "appBeeIT"
strIconLocation = "c:\ProgramData\HrafnaFloki\app-ico_BeeIT.ico"
End Select
Call mcSetWindowsFileShortcut(strShortcutName, strWorkingDirectory, strFileName, strArguments, strHotkey, strDescription, strIconLocation, bytWindowsStyle)
End Sub