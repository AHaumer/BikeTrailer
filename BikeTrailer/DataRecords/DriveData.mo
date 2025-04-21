within BikeTrailer.DataRecords;
record DriveData "Parameters of the drive"
  extends Modelica.Icons.Record;
  replaceable parameter BikeTrailer.DataRecords.DCPM.DcpmData dcpmData
    constrainedby BikeTrailer.DataRecords.DCPM.DcpmData annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-10,40},{10,60}})));
  parameter Real ratio=4 "Gear ratio";
  parameter Modelica.Units.SI.Frequency fs=2e3 "Switching frequency";
  parameter Modelica.Units.SI.Time Td=1.0/fs "Deadtime inverter";
  parameter Modelica.Units.SI.Time Ta = dcpmData.La/dcpmData.RaNominal "Armature time constant";
  parameter Modelica.Units.SI.Voltage VBat=1.25*dcpmData.VaNominal "Battery open-circuit voltage at SOC=1";
  parameter Modelica.Units.SI.Voltage Vmin=0.8*VBat "Minimum battery open-circuit voltage at SOC=0.1";
  parameter Modelica.Units.SI.Current IBat=10*dcpmData.IaNominal "Battery short-circuit current at SOC=1";
  parameter Modelica.Units.SI.ElectricCharge QBat(displayUnit="A.h")=20*3600 "Nominal battery charge";
  parameter Modelica.Units.SI.Current IaMax=1.5*dcpmData.IaNominal "Max. motor current";
  parameter Modelica.Units.SI.Torque tauMax=dcpmData.kPhi*IaMax "Max. motor torque";
  parameter Modelica.Units.SI.Resistance kpI = dcpmData.Ra*Ta/(2*Td) "Proportional gain of current controller";
  parameter Modelica.Units.SI.Time TiI = Ta "Integral time constant of current controller";
  parameter Modelica.Units.SI.Time Tsub = 2*Td "Substitute time constant";
  annotation (defaultComponentPrefixes="parameter");
end DriveData;
