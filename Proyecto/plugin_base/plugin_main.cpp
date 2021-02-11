#include <iostream>
#include <easm.h>
#include "rlutil.h" 

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
            rlutil::resetColor();
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