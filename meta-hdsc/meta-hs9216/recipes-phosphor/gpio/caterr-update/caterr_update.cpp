#include <sdbusplus/bus.hpp>
#include <sdbusplus/bus/match.hpp>
#include <sdbusplus/message.hpp>
#include <sdbusplus/vtable.hpp>
#include <sdbusplus/server/interface.hpp>
#include <iostream>


#define CATERR_OBJECTPATH_BASE "/xyz/openbmc_project/control/processor"
#define CATERR_SERVICE "xyz.openbmc_project.Settings"
#define CATERR_INTERFACE "xyz.openbmc_project.Control.Processor"
#define PROPERTY_INTERFACE "org.freedesktop.DBus.Properties"

/**
 * @brief Main
 */
int main(int argc, char *argv[])
{
    char direction[20]={0};
    int assertflag=0;

    std::string state="xyz.openbmc_project.Control.Processor.State.NORMAL";

    for (int i =0; i < argc; ++i)
    {
        if(strcmp(argv[i],"-d")==0)
        {
            i++;
            assertflag=strtol(argv[i],NULL,10);
            std::printf("Jeannie test value=%d\n",assertflag);
            state=(assertflag)?"xyz.openbmc_project.Control.Processor.State.CATERR":"xyz.openbmc_project.Control.Processor.State.NORMAL";         
        }
    }

    auto bus = sdbusplus::bus::new_default();
    auto method = bus.new_method_call(CATERR_SERVICE, CATERR_OBJECTPATH_BASE,
                                      PROPERTY_INTERFACE, "Set");
    method.append(CATERR_INTERFACE,"ProcessorStatus", sdbusplus::message::variant<std::string>(state));
    bus.call_noreply(method);
    return 0;

}
