within BikeTrailer.DataRecords.DCPM;
record DcpmData "Standard parameters for DC machines"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  import Modelica.Electrical.Machines.Thermal.convertResistance;
  parameter String MachineType="BaseData";
  parameter Modelica.Units.SI.Inertia Jr=0.15 "Rotor's moment of inertia";
  parameter Modelica.Units.SI.Voltage VaNominal=100 "Nominal armature voltage"
    annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.Units.SI.Current IaNominal=100
    "Nominal armature current (>0..Motor, <0..Generator)"
    annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.Units.SI.AngularVelocity wNominal(displayUnit="rpm")=1425*2
    *pi/60 "Nominal speed" annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.Units.SI.Temperature TaNominal(displayUnit="degC")=293.15
    "Nominal armature temperature" annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.Units.SI.Resistance Ra=0.05 "Armature resistance at TaRef"
    annotation (Dialog(tab="Armature"));
  parameter Modelica.Units.SI.Temperature TaRef(displayUnit="degC")=293.15
    "Reference temperature of armature resistance"
    annotation (Dialog(tab="Armature"));
  parameter LinearTemperatureCoefficient20 alpha20a=0
    "Temperature coefficient of armature resistance"
    annotation (Dialog(tab="Armature"));
  parameter Modelica.Units.SI.Inductance La=0.0015 "Armature inductance"
    annotation (Dialog(tab="Armature"));
  // Calculation of additonal parameters
  parameter Modelica.Units.SI.Resistance RaNominal=convertResistance(Ra, TaRef, alpha20a, TaNominal)
    "Armature resistance at nominal temperature"
    annotation (Dialog(tab="Nominal parameters", enable=false));
  parameter Modelica.Units.SI.Voltage ViNominal=VaNominal - RaNominal*IaNominal
    "Induced voltage at nominal operating point"
    annotation (Dialog(tab="Nominal parameters", enable=false));
  parameter Modelica.Units.SI.MagneticFlux kPhi=ViNominal/wNominal "Machine constant"
    annotation (Dialog(tab="Nominal parameters", enable=false));
  parameter Modelica.Units.SI.Torque tauNominal=kPhi*IaNominal
    "Nominal torque"
    annotation (Dialog(tab="Nominal parameters", enable=false));
  annotation (
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={28,108,200},
          textString="%MachineType"),
                   Text(
          extent={{-100,40},{100,10}},
          textColor={28,108,200},
          textString="DCPM")}));
end DcpmData;
