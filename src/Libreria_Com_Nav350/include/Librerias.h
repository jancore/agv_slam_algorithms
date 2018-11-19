
/** 
@mainpage Documentacion general sobre las librerias del AGV

@section NOTICE

##Copyright (C) SMART TECHNOLOGY S.A -- All Rights Reserved##
###The intellectual and technical information contained here and the subsequent files, including documentation and source code, are confidential and proprietary to SMART TECHNOLOGY S.A. Unauthorized copying or use, via any medium is strictly prohibited.###

@subsection Documentacion

- Programacion
	+ @ref page_programacion_agv
	<!-- + @ref page_instruction_set -->
	+ [Listado de instrucciones](@ref agv::programas::instrucciones)
- Comunicaciones
	+ @ref page_protocolo_com_agv
	+ [Listado de comandos] (@ref agv::comtcp::Comandos_Cliente_Robot_Nuevos)
- Errores
	+ Codigos de error en PLC de seguridad
	+ Codigos de error en PLC de control
	+ Codigos de error en controlador

@subsection Procedimientos
	
- @ref page_proc_nuevas_instrucciones
	
@author Jesus Rueda Gonzalez
@date 26/06/2017
*/

#pragma once

#ifndef PARAMETROS_COMP_LIBRERIAS_H
#define PARAMETROS_COMP_LIBRERIAS_H

#define ACTIVAR_MENSAJES
#ifdef ACTIVAR_MENSAJES

//#define MENSAJES_DEBUG_NAVEGACION
//#define MENSAJES_DEBUG_PLC
//#define MENSAJES_DEBUG_CONTROL
#define MENSAJES_INFO_GUI
//#define MENSAJES_ERROR_COMUNICACION
//#define MENSAJES_EXCEPCIONES

#endif

//#define SOPORTE_OPENCV
#ifndef __linux__
	//#define SOPORTE_MYSQL
#endif

#ifdef _WIN32
	#ifndef M_PI
		#define M_PI 3.14159265358979323846
	#endif

	#define NOMINMAX
#endif //_WIN32

#endif