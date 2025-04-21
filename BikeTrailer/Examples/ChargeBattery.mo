within BikeTrailer.Examples;
model ChargeBattery "Charge battery of drive"
  extends Modelica.Icons.Example;
  Drives.Battery                                          battery(SOC(fixed=true,
        start=0.1))             annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={20,0})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Blocks.Continuous.Integrator energy(u(unit="W"), y(unit="J"))
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Electrical.Batteries.Utilities.CCCVcharger
                        cccvCharger(I=50,
    rampTime=30,                          Vend=60) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,0})));
equation
  connect(battery.n,ground. p)
    annotation (Line(points={{20,-10},{20,-20},{0,-20}}, color={0,0,255}));
  connect(powerSensor.nc,battery. p)
    annotation (Line(points={{10,40},{20,40},{20,10}},color={0,0,255}));
  connect(powerSensor.nv,ground. p)
    annotation (Line(points={{0,30},{0,-20}},     color={0,0,255}));
  connect(powerSensor.pc,powerSensor. pv) annotation (Line(points={{-10,40},{-10,
          50},{0,50}},        color={0,0,255}));
  connect(powerSensor.power,energy. u)
    annotation (Line(points={{-10,29},{-10,20},{38,20}}, color={0,0,127}));
  connect(powerSensor.pc,cccvCharger. p) annotation (Line(points={{-10,40},{-30,
          40},{-30,10}},      color={0,0,255}));
  connect(ground.p,cccvCharger. n) annotation (Line(points={{0,-20},{-30,-20},{-30,
          -10}},           color={0,0,255}));
  annotation (experiment(
      StopTime=7200,
      Interval=0.1,
      Tolerance=1e-06), Documentation(info="<html>
<p>
Chrage the battery with a CC-CV-charger (first constant current, when reaching charge cut-off voltage constant voltage).
</p>
</html>"));
end ChargeBattery;
