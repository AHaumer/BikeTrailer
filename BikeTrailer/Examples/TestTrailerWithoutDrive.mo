within BikeTrailer.Examples;
model TestTrailerWithoutDrive "Test the trailer without drive"
  extends Modelica.Icons.Example;
  Components.Trailer trailer(data = data, useWindInput = true, usecrInput = false, useInclinationInput = true, s(fixed = true)) annotation (
    Placement(transformation(extent = {{10, -10}, {30, 10}})));
  parameter DataRecords.Data data annotation (
    Placement(transformation(extent = {{-10, 60}, {10, 80}})));
  Modelica.Blocks.Sources.Constant tauRef(k = 0) annotation (
    Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Blocks.Math.Gain from_kmh(k = 1/3.6) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-40, 0})));
  Modelica.Mechanics.Translational.Sources.Speed bike(exact = false, f_crit = 100, s(fixed = false)) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-10, 0})));
  Modelica.Blocks.Sources.Ramp vRef(
    height=25,
    duration=30,
    offset=0,
    startTime=10)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.Pulse inclination(
    amplitude=0.1,
    width=50,
    period=60,
    nperiod=1,
    offset=0,
    startTime=60)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.Pulse windSpeed(
    amplitude=10,
    width=50,
    period=60,
    nperiod=1,
    offset=0,
    startTime=120)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
equation
  connect(from_kmh.y, bike.v_ref) annotation (
    Line(points = {{-29, 0}, {-22, 0}}, color = {0, 0, 127}));
  connect(bike.flange, trailer.flange) annotation (
    Line(points = {{0, 0}, {10, 0}}, color = {0, 127, 0}));
  connect(tauRef.y, trailer.tauRef) annotation (
    Line(points={{31,30},{40,30},{40,0},{30,0}},
                                      color = {0, 0, 127}));
  connect(vRef.y, from_kmh.u)
    annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(inclination.y, trailer.inclination)
    annotation (Line(points={{1,-50},{26,-50},{26,-12}}, color={0,0,127}));
  connect(windSpeed.y, trailer.vWind)
    annotation (Line(points={{-19,-30},{14,-30},{14,-12}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=180,
      Interval=0.0001,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
The bike is modeled as a prescribed speed, i.e. the biker is strong enough to reach the prescribed speed. 
The force between bike and trailer is measured but not compensated (<code>tauRef=0</code>).
</p>
<ul>
<li>t = [ 10.. 40] s: acceleration from 0 to 25 km/h</li>
<li>t = [ 60.. 90] s: inclination = 0.1 (uphill)</li>
<li>t = [120..150] s: wind speed = 10 m/s (in direction of movement)</li>
</ul>
</html>"));
end TestTrailerWithoutDrive;
