#include <iostream>
#include <easm.h>
#include "rlutil.h" 

extern "C" ErrorCode handleSyscall(uint32_t *regs, void *mem, MemoryMap *mem_map)
{
    unsigned v0 = regs[Register::v0];

    switch (v0)
    {
        case 20:
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            regs[Register::v0] = a0 + a1;
            return ErrorCode::Ok;
        }
        case 21:
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            for (size_t i = 0; i < a0; i++)
            {
                rlutil::setColor(a1);
        		std::cout << i << " ";
            }
            rlutil::resetColor();
            return ErrorCode::Ok;
        }
        case 22:
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            for (size_t i = 0; i < a0; i++)
            {
                rlutil::setBackgroundColor(a1);
        		std::cout << i << " ";
            }
            rlutil::resetColor();
            return ErrorCode::Ok;
        }
        case 23:
        {
            rlutil::cls();
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