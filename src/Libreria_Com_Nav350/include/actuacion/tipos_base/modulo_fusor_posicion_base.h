// Copyright (C) 2018 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: modulo_fusor_sensorial_base.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2018/6/25

#pragma once

#include "../../Librerias.h"
#include "../../generales/geometria/punto.h"
//STL
#include <string>
#include <vector>

namespace agv
{
	namespace actuacion
	{
		class SensorPosicionamientoBase
		{
		public:
			virtual ~SensorPosicionamientoBase() = default;
			virtual agv::DatosPose calcula_pose(const agv::DatosPose& p_pose_estimada) = 0;
			virtual agv::DatosPose get_ultima_pose() const = 0;
			virtual bool esta_posicionado() const = 0;
			virtual int get_error_pos() const = 0;
			virtual int get_prioridad_sensor() const = 0;
		};

		class ModuloFusorPosicionBase
		{
		public:
			enum Tipo_Posicionamiento
			{
				STATIC,
				INTERNAL,
			};

			virtual ~ModuloFusorPosicionBase() = default;
			
			virtual agv::DatosPose calcula_pose() = 0;
			virtual agv::DatosPose get_ultima_pose() const = 0;
			virtual bool esta_posicionado() const = 0;
			virtual int get_error_pos() const = 0;

			virtual void set_tipo_posicionamiento(Tipo_Posicionamiento p_tipo_posicionamiento) = 0;
			virtual Tipo_Posicionamiento get_tipo_posicionamiento() const = 0;

			virtual void set_posicionamiento_estatico(const agv::DatosPose& p_pose) = 0;
		};
	}
}
