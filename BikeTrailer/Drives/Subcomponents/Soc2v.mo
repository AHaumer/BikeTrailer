within BikeTrailer.Drives.Subcomponents;
block Soc2v "Dependency of voltage on SOC"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.Units.SI.Voltage Voc "Open circuit voltage at SOC=1";
  parameter Modelica.Units.SI.Voltage Vmin "Minimum open-circuit voltage at SOCmin";
  parameter Real SOCmin=0.1 "Minimum SOC";
equation
  assert(u<=1, "Battery overcharged");
  assert(u>=SOCmin, "Battery exhausted");
  y = if u >= SOCmin then Vmin + (Voc - Vmin)*(u - SOCmin)/(1 - SOCmin) else Vmin*u/SOCmin;
end Soc2v;
