 /***********************************************************************************************
 * SOFTWARE RSL400
 *
 * This code is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE
 *
 * Description:
 * Stateimage of RSL400
 *
 **************************************************************************************************/
#include <stdint.h>

#pragma once

#pragma pack(1)

namespace RSL400 {
    typedef uint32_t DWORD;
    typedef uint16_t WORD;
        
	// Protection Function
	typedef struct tagProtectionFunction {
		unsigned char b0_Res1        	:3; // reserved
		unsigned char IsFFOutActive		:1; // A-CLEAR
		unsigned char IsRestartActive	:1; // A-RES
		unsigned char IsPfFree			:1; // A-PF-VIO
		unsigned char IsWfFree			:1; // A-WF-VIO
		unsigned char IsActive			:1; // A-ACTIVE

		unsigned char SelFieldPair1		:4; // A-PAIR-SEL 1
 		unsigned char SelBank			:4; // A-BANK-SEL
		
		unsigned char SelFieldPair3		:4; // A-PAIR-SEL 3
		unsigned char SelFieldPair2		:4; // A-PAIR-SEL 2

		unsigned char b3_Res1	        :2; // reserved
		unsigned char IsFpSel2			:1; // A-FP-SEL-2
		unsigned char IsFpSel1			:1; // A-FP-SEL-1
		unsigned char IsPfSeg2Free		:1; // A-PF-VIO-SEG-2
		unsigned char IsPfSeg1Free		:1; // A-PF-VIO-SEG-1
		unsigned char IsWfSeg2Free		:1; // A-WF-VIO-SEG-2
		unsigned char IsWfSeg1Free		:1; // A-WF-VIO-SEG-1
	} ProtectionFunction, *PProtectionFunction;

	typedef struct tagStateImageType {
		unsigned char TypeID;				// State image type ID
	} StateImageType, *PStateImageType;

	// State Image (Type 1)
	typedef struct tagStateImageType1 : StateImageType {
		unsigned char OperationMode;				// OP-MODE

		union {
			unsigned char Data[18];					// index based access
			struct {
				unsigned char IsOssdB         	:1; // B-OSSD
				unsigned char IsOssdA         	:1; // A-OSSD
				unsigned char IsEStopError    	:1; // E-STOP
				unsigned char IsFieldPairError	:1; // FIELD PAIR
				unsigned char IsEdm           	:1; // EDM
				unsigned char IsScreen        	:1; // SCREEN
				unsigned char IsAlarm         	:1; // ALARM
				unsigned char IsError         	:1; // ERROR

				unsigned char b1_Res1        	:2; // reserved 
				unsigned char IsRflSeg4        	:1; // RFL-SEG-4
				unsigned char IsRflSeg3        	:1; // RFL-SEG-3
				unsigned char IsRflSeg2        	:1; // RFL-SEG-2 
				unsigned char IsRflSeg1        	:1; // RFL-SEG-1
				unsigned char IsModePark       	:1; // Mode-PARK
				unsigned char IsStatusInputSeOn	:1; // Status-Input-SE

				unsigned char IsF8				:1; // F8
				unsigned char IsF7				:1; // F7
				unsigned char IsF6				:1; // F6
				unsigned char IsF5				:1; // F5
				unsigned char IsF4				:1; // F4
				unsigned char IsF3				:1; // F3
				unsigned char IsF2				:1; // F2
				unsigned char IsF1				:1; // F1

				unsigned char IsEA4 			:1; // EA4
				unsigned char IsEA3 			:1; // EA3
				unsigned char IsEA2 			:1; // EA2
				unsigned char IsEA1 			:1; // EA1
				unsigned char IsRes2			:1; // RES2
				unsigned char IsRes1			:1; // RES1
				unsigned char IsF10 			:1; // F10
				unsigned char IsF9  			:1; // F9
				
				unsigned char IsMELD  			:1; // MELD
				unsigned char IsA4    			:1; // A4
				unsigned char IsA3    			:1; // A3
				unsigned char IsA2    			:1; // A2
				unsigned char IsA1    			:1; // A1
				unsigned char IsNpnPnP			:1; // PNP-NPN
				unsigned char IsSE2   			:1; // SE2
				unsigned char IsSE1   			:1; // SE1

				unsigned char b5_Res1;				// reserved

				DWORD ScanNo;						// SCAN
				
				ProtectionFunction ProtFuncA;		// Protection Function A
				ProtectionFunction ProtFuncB;       // Protection Function A
			};
		};
	} StateImageType1, *PStateImageType1;
}

#pragma pack()