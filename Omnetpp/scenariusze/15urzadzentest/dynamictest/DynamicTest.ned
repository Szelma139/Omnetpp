
package inet.examples.ospfv2.dynamictest;



import inet.common.misc.ThruputMeteringChannel;
import inet.common.scenario.ScenarioManager;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.StandardHost;
import inet.node.ospfv2.OspfRouter;


network DynamicTest
{
    parameters:
        @display("p=10,10;b=712,152");
    types:
        channel C extends ThruputMeteringChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
            thruputDisplayFormat = "#N";
        }
    submodules:
        H1: StandardHost {
            parameters:
                @display("p=124,200");
            gates:
                ethg[1];
        }
        R1: OspfRouter {
            parameters:
                @display("p=250,200");
            gates:
                ethg[4];
        }
        RA: OspfRouter {
            parameters:
                @display("p=355,108");
            gates:
                ethg[3];
        }
        
        
        
        
        
         RU: OspfRouter {
            parameters:
                @display("p=450,50");
            gates:
                ethg[2];
        }
        RB: OspfRouter {
            parameters:
                @display("p=345,300");
            gates:
                ethg[2];

        }

        RC: OspfRouter {
            parameters:
                @display("p=500,108");
            gates:
                ethg[4];
        }



        RD: OspfRouter {
            parameters:
                @display("p=483,306");
            gates:
                ethg[2];
        }


        R2: OspfRouter {
            parameters:
                @display("p=700,200");
            gates:
                ethg[5];
        }
        H2: StandardHost {
            parameters:
                @display("p=850,200");
            gates:
                ethg[1];
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=36,145;is=s");
                config = xml("<config>"
                        + "<interface among='H1 R1' address='192.168.1.x' netmask='255.255.255.x' />"
                        + "<interface among='H2 R2' address='192.168.2.x' netmask='255.255.255.x' />"
                         + "<interface among='H3 RM' address='192.168.3.x' netmask='255.255.255.x' />"
                        + "<interface among='R*' address='10.0.0.x' netmask='255.255.255.x' />"
                        + "<multicast-group hosts='R*' address='224.0.0.5 224.0.0.6' />"
                        + "<route hosts='H1' destination='*' gateway='R1'/>"
                        + "<route hosts='H2' destination='*' gateway='R2'/>"
                          + "<route hosts='H3' destination='*' gateway='RM'/>"
                        + "<route hosts='R*' destination='224.0.0.0' netmask='240.0.0.0' interface='eth0'/>"
                        + "<route hosts='R*' destination='224.0.0.0' netmask='240.0.0.0' interface='eth1'/>"
                        + "<route hosts='R1 R2' destination='224.0.0.0' netmask='240.0.0.0' interface='eth2'/>"
                        + "</config>");
        }
        scenarioManager: ScenarioManager {
            @display("p=71,350;is=s");
        }
        RK: OspfRouter {
                parameters:
            @display("p=338,419");
             gates:
                ethg[3];
        }
        RL: OspfRouter {
                parameters:
            @display("p=508,419");
             gates:
                ethg[3];
        }
        
          RM: OspfRouter {
                parameters:
            @display("p=400,480");
             gates:
                ethg[3];
        }
        
        H3: StandardHost {
            parameters:
                @display("p=400,550");
            gates:
                ethg[1];
        }
        
        
         RP: OspfRouter {
                parameters:
           @display("p=570,108");
             gates:
                ethg[2];
        }
    connections:
        H1.ethg[0] <--> C <--> R1.ethg[0];
        R1.ethg[1] <--> C <--> RA.ethg[0];
        R1.ethg[2] <--> C <--> RB.ethg[0];
        R2.ethg[0] <--> C <--> H2.ethg[0];
        RA.ethg[1] <--> C <--> RC.ethg[0];
        RB.ethg[1] <--> C <--> RD.ethg[0];
        RC.ethg[1] <--> C <--> R2.ethg[1];
        RD.ethg[1] <--> C <--> R2.ethg[2];      
           R1.ethg[3] <--> C <--> RK.ethg[0];
           RK.ethg[1] <--> C <--> RL.ethg[0];
           RL.ethg[1] <--> C <--> R2.ethg[3];
            RM.ethg[0] <--> C <--> H3.ethg[0];
           RK.ethg[2] <--> C <--> RM.ethg[1];
           RM.ethg[2] <--> C <--> RL.ethg[2];
           
                RP.ethg[0] <--> C <--> RC.ethg[2];
                RP.ethg[1] <--> C <--> R2.ethg[4];
                RA.ethg[2] <--> C <--> RU.ethg[0];
                RU.ethg[1] <--> C <--> RC.ethg[3];
                
}

