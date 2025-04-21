within BikeTrailer.DataRecords.DCPM;
record UniteM "Unite M 48V"
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  extends BikeTrailer.DataRecords.DCPM.DcpmData(
    MachineType="Unite 48V",
    Jr=0.0016,
    VaNominal=48,
    IaNominal=25,
    wNominal=1750*2*pi/60,
    TaNominal=368.15,
    Ra=0.18545,
    TaRef=293.15,
    alpha20a=alpha20Copper,
    La=0.40e-3);
  annotation (
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
</html>"));
end UniteM;
