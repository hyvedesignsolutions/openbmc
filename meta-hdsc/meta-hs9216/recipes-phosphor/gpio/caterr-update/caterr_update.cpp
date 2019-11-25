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

#define CHASSIS_STATE_OBJECT "/xyz/openbmc_project/state/chassis0"
#define CHASSIS_SERVICE "xyz.openbmc_project.State.Chassis"
#define CHASSIS_INTERFACE "xyz.openbmc_project.State.Chassis"


static int getPropertyString(sdbusplus::bus::bus& bus, const std::string& path,
       const std::string& property, std::string& value, const std::string service, const std::string interface)
{
    auto method = bus.new_method_call(service.c_str(), path.c_str(), PROPERTY_INTERFACE, "Get");
    method.append(interface.c_str(),property);
    auto reply=bus.call(method);
    if (reply.is_method_error())
    {
        std::printf("Error looking up services, PATH=%s",interface.c_str());
        return -1;
    }

    sdbusplus::message::variant<std::string> valuetmp;
    try
    {
        reply.read(valuetmp);
    }
    catch (const sdbusplus::exception::SdBusError& e)
    {
        std::printf("Failed to get pattern string for match process");
        return -1;
    }

    value = std::get<std::string>(valuetmp);
    return 0;
}

/**
 * @brief Main
 */
int main(int argc, char *argv[])
{
    char direction[20]={0};
    char powerpath[100]={0};
    std::string responseData;
    int assertflag=0, ret=0;

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
    
    //Get power status first, if power is off , ignore the function and exit.
    ret = getPropertyString(bus,CHASSIS_STATE_OBJECT,"CurrentPowerState",responseData,CHASSIS_SERVICE,CHASSIS_INTERFACE);
    auto index = responseData.find_last_of(".");
    std::string psstate = responseData.substr(index+1);
    std::printf("Jeannie test power state=%s\n",psstate.c_str());
    if(psstate == "Off")
    {
        return 0;
    }

    auto method = bus.new_method_call(CATERR_SERVICE, CATERR_OBJECTPATH_BASE,
                                      PROPERTY_INTERFACE, "Set");
    method.append(CATERR_INTERFACE,"ProcessorStatus", sdbusplus::message::variant<std::string>(state));
    bus.call_noreply(method);
    return 0;

}
