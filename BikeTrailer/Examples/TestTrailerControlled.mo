within BikeTrailer.Examples;
model TestTrailerControlled "Test control of the trailer"
  extends Modelica.Icons.Example;
  Components.Trailer trailer(
    data=data,
    useWindInput=true,
    usecrInput=false,
    useInclinationInput=true,
    s(fixed=true))
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  parameter DataRecords.Data data
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=data.kp,
    Ti=data.Ti,
    Td=data.Td,
    yMax=data.tauMax,
    yMin=data.tauMin,
    Ni=1,
    Nd=1/data.k,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Blocks.Sources.Constant fRef(k=0)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.CombiTimeTable track(table=[0,0,0,0; 60,25,0,0; 120,25,
        -5,0; 120,25,-5,0.1; 180,20,0,0.1; 180,20,0,-0.1; 240,30,5,-0.1; 240,30,
        5,0; 300,25,0,0; 360,0,0,0; 420,0,0,0], extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,0})));
  Modelica.Blocks.Math.Gain from_kmh(k=1/3.6)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));
  Modelica.Mechanics.Translational.Sources.Speed bike(s(fixed=false), exact=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,0})));
equation
  connect(trailer.f, PID.u_m)
    annotation (Line(points={{20,11},{20,18}}, color={0,0,127}));
  connect(PID.y, trailer.tauRef)
    annotation (Line(points={{31,30},{40,30},{40,0},{30,0}}, color={0,0,127}));
  connect(fRef.y, PID.u_s)
    annotation (Line(points={{1,30},{8,30}}, color={0,0,127}));
  connect(from_kmh.y, bike.v_ref)
    annotation (Line(points={{-29,0},{-22,0}}, color={0,0,127}));
  connect(track.y[1], from_kmh.u)
    annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(bike.flange, trailer.flange)
    annotation (Line(points={{0,0},{10,0}}, color={0,127,0}));
  connect(track.y[2], trailer.vWind) annotation (Line(points={{-69,0},{-60,0},{
          -60,-20},{14,-20},{14,-12}},
                                   color={0,0,127}));
  connect(track.y[3], trailer.inclination) annotation (Line(points={{-69,0},{
          -60,0},{-60,-20},{26,-20},{26,-12}},
                                           color={0,0,127}));
  annotation (experiment(StopTime=420, Interval=0.001), Documentation(info="<html>
<p>
The time table <code>track</code> prescribes:
</p>
<ul>
<li>the velocity [km/h] of the <code>bike</code>.</li>
<li>the wind speed [m/s] (positive = in direction of movement / from behind)</li>
<li>the inclination = <code>tan(angle)</code>.</li>
</ul>
<p>
The bike is modeled as a prescribed speed, i.e. the biker is strong enough to reach the prescribed speed. 
The force between bike and trailer is intended to get compensated by controlling the electrical drive(s) with prescribed torque.
</p>
</html>"));
end TestTrailerControlled;
