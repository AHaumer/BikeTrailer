within BikeTrailer.DataRecords;
record TrailerData "Parameters of the bike trailer"
  extends Modelica.Icons.Record;
  //common trailer parameters
  parameter Modelica.Units.SI.Mass m=50 "Total mass of trailer incl. load";
  parameter Modelica.Units.SI.Inertia J=0.2 "Inertia of trailer wheel(s)";
  parameter Modelica.Units.SI.Length D=0.4 "Diameter of trailer wheel(s)";
  parameter Modelica.Units.SI.Area A=1 "Cross section of trailer";
  //resistance parameters
  parameter Real cw=0.5 "Drag resistance coefficient"
    annotation(Dialog(tab="Resistances", group="Air drag"));
  parameter Modelica.Units.SI.Density rho=1.18 "Density of air at 25 degC"
    annotation (Dialog(tab="Resistances", group="Air drag"));
  parameter Real cr=0.05 "Constant rolling resistance coefficient"
    annotation(Dialog(tab="Resistances", group="Rolling"));
  //drive parameters
  parameter Modelica.Units.SI.Time Tsub=1E-3
    "Substitute time constant of trailer drives(s)"
    annotation (Dialog(tab="Drive"));
  parameter Modelica.Units.SI.Torque tauMax=30
    "Max. torque of trailer drives(s)" annotation (Dialog(tab="Drive"));
  parameter Modelica.Units.SI.Torque tauMin=-30
    "Min. torque of trailer drives(s)" annotation (Dialog(tab="Drive"));
  //controller parameters
  parameter Real kp=D/2 "Proportional gain of controller"
    annotation(Dialog(tab="Drive", group="Controller"));
  parameter Modelica.Units.SI.Time Ti=Tsub/2*(1 + sqrt((1 - k)/(1 + k)))
    "Integral time constant of controller"
    annotation (Dialog(tab="Drive", group="Controller"));
  parameter Real k(min=Modelica.Constants.eps, max=8/17)=8/17 "Inverse of Nd of controller"
    annotation(Dialog(tab="Drive", group="Controller"));
  parameter Modelica.Units.SI.Time Td=Tsub/((1 + k) + sqrt(1 - k^2))
    "Derivative time constant of controller"
    annotation (Dialog(tab="Drive", group="Controller"));
  annotation (defaultComponentPrefixes="parameter");
end TrailerData;
