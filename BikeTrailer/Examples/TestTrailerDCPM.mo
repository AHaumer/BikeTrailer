within BikeTrailer.Examples;
model TestTrailerDCPM "Test trailer with DCPM-drive"
  extends Modelica.Icons.Example;
  Components.Trailer trailer(
    trailerData=trailerData,
    useWindInput=true,
    usecrInput=true,
    useInclinationInput=true,
    s(fixed=true))
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  parameter DataRecords.TrailerData trailerData(
    Tsub=dcpmDrive.driveData.Tsub,
    tauMax=dcpmDrive.driveData.tauMax,
    tauMin=-dcpmDrive.driveData.tauMax)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=trailerData.kp,
    Ti=trailerData.Ti,
    Td=trailerData.Td,
    yMax=trailerData.tauMax,
    yMin=trailerData.tauMin,
    Ni=1,
    Nd=1/trailerData.k,
    initType=Modelica.Blocks.Types.Init.InitialState)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Blocks.Sources.Constant fRef(k=0)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Math.Gain from_kmh(k=1/3.6)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));
  Modelica.Mechanics.Translational.Sources.Speed bike(s(fixed=false),
    exact=false,
    f_crit=100)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,0})));
  Components.DcpmDrive dcpmDrive(SOC(fixed=true), driveData(redeclare
        BikeTrailer.DataRecords.DCPM.UniteM dcpmData))
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  parameter DataRecords.TrackData trackData
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Blocks.Sources.CombiTimeTable track(table=trackData.trackTable,
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,0})));
equation
  connect(fRef.y, PID.u_s)
    annotation (Line(points={{1,30},{8,30}}, color={0,0,127}));
  connect(from_kmh.y, bike.v_ref)
    annotation (Line(points={{-29,0},{-22,0}}, color={0,0,127}));
  connect(dcpmDrive.shaft, trailer.shaft)
    annotation (Line(points={{40,0},{30,0}}, color={0,0,0}));
  connect(PID.y, dcpmDrive.tauRef)
    annotation (Line(points={{31,30},{50,30},{50,12}}, color={0,0,127}));
  connect(PID.u_m, trailer.f)
    annotation (Line(points={{20,18},{20,11}}, color={0,0,127}));
  connect(bike.flange, trailer.flange)
    annotation (Line(points={{0,0},{10,0}}, color={0,127,0}));
  connect(track.y[1], from_kmh.u)
    annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(track.y[2], trailer.vWind) annotation (Line(points={{-69,0},{-60,0},{
          -60,-20},{14,-20},{14,-12}}, color={0,0,127}));
  connect(track.y[3], trailer.cr) annotation (Line(points={{-69,0},{-60,0},{-60,
          -20},{20,-20},{20,-12}}, color={0,0,127}));
  connect(track.y[4], trailer.inclination) annotation (Line(points={{-69,0},{
          -60,0},{-60,-20},{26,-20},{26,-12}}, color={0,0,127}));
  annotation (experiment(
      StopTime=420,
      Interval=0.0005,
      Tolerance=1e-06),                      Documentation(info="<html>
<p>
The time table <code>track</code> prescribes:
</p>
<ul>
<li>the velocity [km/h] of the <code>bike</code>.</li>
<li>the wind speed [m/s] (positive = in direction of movement / from behind)</li>
<li>rolling resistance coefficient</li>
<li>the inclination = <code>tan(angle)</code> (positive = uphill).</li>
</ul>
<p>
The bike is modeled as a prescribed speed, i.e. the biker is strong enough to reach the prescribed speed. 
The force between bike and trailer is intended to get compensated by controlling the electrical drive(s) with prescribed torque.
</p>
<p>
The reference force <code>fRef</code> describes the force demanded from the bike, normally zero. 
Negative means additional resistance, positive means additional support for the bike.
</p>
</html>"));
end TestTrailerDCPM;
