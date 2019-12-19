//#include <sdbusplus/bus.hpp>
//#include <sdbusplus/bus/match.hpp>
//#include <sdbusplus/message.hpp>
//#include <sdbusplus/vtable.hpp>
//#include <sdbusplus/server/interface.hpp>
#include <sdbusplus/message/types.hpp>
#include <sdbusplus/timer.hpp>

#include <boost/asio.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/container/flat_map.hpp>
#include <boost/process.hpp>
#include <iostream>

#include <unistd.h>
#include <sdbusplus/asio/object_server.hpp>

#define BOOST_COROUTINES_NO_DEPRECATION_WARNING 

#define HOST_SERVICE "xyz.openbmc_project.State.Host"
#define HOST_OBJECTPATH_BASE "/xyz/openbmc_project/state/host0"
#define HOST_BOOTPROGRESS_INTERFACE "xyz.openbmc_project.State.Boot.Progress"
#define HOST_OPERATINGSYSTEM_INTERFACE "xyz.openbmc_project.State.OperatingSystem.Status"
#define PROPERTY_INTERFACE "org.freedesktop.DBus.Properties"


static constexpr char const* ipmiSELService =    "xyz.openbmc_project.Logging.IPMI";
static constexpr char const* ipmiSELPath = "/xyz/openbmc_project/Logging/IPMI";
static constexpr char const* ipmiSELAddInterface = "xyz.openbmc_project.Logging.IPMI";
static const std::string ipmiSELAddMessage = "SEL Entry";

/**
 * @brief Main
 */
int main(int argc, char *argv[])
{
    char sensorType[20]={0};
    char sensorName[20]={0};
    char eventName[20]={0};
    uint16_t genid = 0x20;
    bool assert=1;
    boost::asio::io_service io;
    std::vector<uint8_t> eventData(3, 0xFF);
    std::string sensorPath;
    auto bus = sdbusplus::bus::new_default();
    


    sscanf(argv[1],"%[^-]-%[^-]-%s",sensorType,sensorName,eventName);
    //assertflag=strtol(argv[i],NULL,10);
    std::printf("sensortype=%s sensorname=%s eventName=%s\n",sensorType,sensorName,eventName);
    
    sensorPath=std::string("/xyz/openbmc_project/sensors/")+sensorType+std::string("/")+sensorName;
    std::printf("Sensorpath:%s\n",sensorPath.c_str());
    std::string sensorNameString = sensorName;
    std::string eventNameString = eventName;
   if(sensorNameString == "THERMAL_TRIP")
   {
       //OEM byte2 ==cpu number
       int cpunum=0;
       eventData[0]=0xa1;  
       /* Change to use processor type   
        * eventdata 1 --> 01h: thermal trip | 0xa : (enable oem eventdata2 & eventdat3)
        * eventdata 2 --> thermal trip type
        * eventdata 3 --> cpunum 
        */ 
       if(eventNameString == "cputhermal")
       {
           eventData[1]=0;  //00h CPU thermal trip
           sscanf(eventName,"cputhermal%x",&cpunum);
           eventData[2]=cpunum;
       }else if(eventNameString == "memorythermal")
       {
           eventData[1]=1;  //01h Memory thermal trip
           sscanf(eventName,"memorythermal%x",&cpunum);
           eventData[2]=cpunum;
       }else if(eventNameString == "pchthermal")
       {
           eventData[0]=2;  //01h PCH thermal trip
       }else{
           return 0;   //no event
       }
       
   }
   else if(sensorNameString == "SYS_BOOT_STATUS")
   { 
      std::string bootstate;
      std::string operationstate;
      auto method = bus.new_method_call(HOST_SERVICE,
                                        HOST_OBJECTPATH_BASE, PROPERTY_INTERFACE, "Set");
      if(eventNameString == "poststart")
      {
	  static int poststartflag = 0; //workaround fix to fix signal problem.

	  if(access("/var/tmp/poststart", F_OK)==0)          
          {
              printf("event already trigger!");
              return 0;
          }

          eventData[0] = 0x1;
          eventData[1] = 0x3;
          bootstate = "xyz.openbmc_project.State.Boot.Progress.ProgressStages.MotherboardInit";
          operationstate = "xyz.openbmc_project.State.OperatingSystem.Status.OSStatus.Inactive";
	  open("/var/tmp/poststart",O_RDONLY | O_CREAT, 0644);
          
      }else if(eventNameString == "postend")
      {
          eventData[0] = 0x1;
          eventData[1] = 0x5;
          //update boot progress          
          bootstate = "xyz.openbmc_project.State.Boot.Progress.ProgressStages.OSStart";

          // update operatingsystem state
          operationstate = "xyz.openbmc_project.State.OperatingSystem.Status.OSStatus.BootComplete";

	  unlink("/var/tmp/poststart");
      }
        
      if(bootstate!="") 
      {
          std::cout << "Update boot Progress state\n"; 
          method.append(HOST_BOOTPROGRESS_INTERFACE, "BootProgress",sdbusplus::message::variant<std::string>(bootstate));
          bus.call_noreply(method);
      }

      if(operationstate!="") 
      {
          std::cout << "Update boot Progress state\n";
          method.append(HOST_OPERATINGSYSTEM_INTERFACE, "OperatingSystemState",sdbusplus::message::variant<std::string>(operationstate));   
          bus.call_noreply(method);
      } 
   }
   //reservce for other sensor
   //else{

   //}


   auto systemBus = std::make_shared<sdbusplus::asio::connection>(io);
   sdbusplus::message::message writeSEL = systemBus->new_method_call(
                            ipmiSELService, ipmiSELPath, ipmiSELAddInterface, "IpmiSelAdd");
   writeSEL.append(ipmiSELAddMessage,sensorPath, eventData, assert, genid);
   try
   {
       systemBus->call(writeSEL);
   }
   catch (sdbusplus::exception_t& e)
   {
       std::cerr << "call IpmiSelAdd failed\n";
   }

    return 0;

}
