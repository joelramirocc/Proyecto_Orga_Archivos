#include <iostream>
#include <easm.h>
#include "rlutil.h" 
#include <stdio.h>
#include <stdlib.h>
#include <ctime>

using namespace std;
extern "C" ErrorCode handleSyscall(uint32_t *regs, void *mem, MemoryMap *mem_map)
{
    unsigned v0 = regs[Register::v0];
    switch (v0)
    {
        case 20:
        {
            rlutil::setColor(regs[Register::a0]);
            return ErrorCode::Ok;
        }
        case 21:
        {   
            rlutil::setColor(rlutil::BLACK);
            return ErrorCode::Ok;
        }
        case 22:
        {   
            int result = (rand() % 4);
            regs[Register::v0] = result;
            return ErrorCode::Ok;
        }
        case 23:
        {
            int dColor = regs[Register::a0];
            int color = dColor == 1?10:dColor ==2?6:4;
            rlutil::setColor(color);
            return ErrorCode::Ok;
        }
        case 24:
        {
            rlutil::cls();
            return ErrorCode::Ok;
        }
        case 25:
        {
            rlutil::msleep(600);
            regs[Register::v0] = rlutil::nb_getch();
            return ErrorCode::Ok;
        }
        case 26:
        {
            regs[Register::v0] = rlutil::getkey();
            return ErrorCode::Ok;
        }
        case 27:
        {
            rlutil::setBackgroundColor(rlutil::BLACK);
            rlutil::setColor(rlutil::BLACK);
            return ErrorCode::Ok;
        }
        case 28:
        {
            rlutil::setColor(rlutil::WHITE);
            return ErrorCode::Ok;
        }
        default:
            if (v0 > 20 && v0 <= 50)
            {
                std::cout << "Syscall: " << v0 << '\n' << std::flush;
                return ErrorCode::Ok;
            }
            else
            {
                return ErrorCode::SyscallNotImplemented;
            }
    }
}


/*CASE DESCRIPTION

20 = establecer fondo de pantalla
21  =   Pintar fondo de pantalla
    a0=StartPaintX
    a1=EndPaintX
    a2=StartPaintY
    a3=EndPaintY
*/