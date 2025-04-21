within BikeTrailer.Components;
model Trailer "Model of a bike trailer"
  extends Icons.TrailerIcon;
  parameter DataRecords.TrailerData trailerData
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  parameter Boolean useWindInput=false "Enable signal input for wind velocity";
  parameter Modelica.Units.SI.Velocity vWindConstant=0 "Constant wind velocity"
    annotation(Dialog(enable=not useWindInput));
  parameter Boolean usecrInput=false "Enable signal input for rolling resistance coefficient";
  parameter Boolean useInclinationInput=false "Enable signal input for inclination";
  parameter Real inclinationConstant=0 "Constant inclination = tan(angle)"
    annotation(Dialog(enable=not useInclinationInput));
  Modelica.Units.SI.Position s(displayUnit="km", start=0)=vehicle.s "Position of trailer";
  Modelica.Units.SI.Velocity v(displayUnit="km/h", start=0)=vehicle.v "Velocity of trailer";
  Modelica.Blocks.Interfaces.RealOutput f(unit="N") "force: positive means trailer is pushing" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Units.SI.Power PBike=-multiSensorBike.power "Power consumption from bike";
  Modelica.Units.SI.Energy EBike=-energyBike.y "Energy consumption from bike";
  Modelica.Units.SI.Power PDrive=multiSensorDrive.power "Power consumption from drive";
  Modelica.Units.SI.Energy EDrive=energyDrive.y "Energy consumption from drive";
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Translational.Sensors.MultiSensor multiSensorBike
    annotation (Placement(transformation(extent={{-40,10},{-60,-10}})));
  Modelica.Blocks.Continuous.Integrator energyBike
    annotation (Placement(transformation(extent={{-30,20},{-10,40}})));
  Modelica.Mechanics.Translational.Components.Vehicle vehicle(
    m=trailerData.m,
    J=trailerData.J,
    R=trailerData.D/2,
    A=trailerData.A,
    Cd=trailerData.cw,
    rho=trailerData.rho,
    useWindInput=useWindInput,
    vWindConstant=vWindConstant,
    useCrInput=usecrInput,
    CrConstant=trailerData.cr,
    useInclinationInput=useInclinationInput,
    inclinationConstant=inclinationConstant)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Modelica.Blocks.Interfaces.RealInput inclination if useInclinationInput
    "Inclination=tan(angle)"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Blocks.Interfaces.RealInput cr if usecrInput
    "Rolling resistance coefficient"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput vWind(unit="m/s") if useWindInput
    "Wind velocity"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Mechanics.Rotational.Sensors.MultiSensor multiSensorDrive
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,0})));
  Modelica.Blocks.Continuous.Integrator energyDrive
    annotation (Placement(transformation(extent={{70,20},{90,40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft "Opzional shaft for drive"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(flange, multiSensorBike.flange_b)
    annotation (Line(points={{-100,0},{-60,0}}, color={0,127,0}));
  connect(multiSensorBike.flange_a, vehicle.flangeT)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,0}));
  connect(cr, vehicle.cr) annotation (Line(points={{0,-120},{0,-12}},
                 color={0,0,127}));
  connect(vWind, vehicle.vWind) annotation (Line(points={{-60,-120},{-60,-14},{
          -6,-14},{-6,-12}},
                           color={0,0,127}));
  connect(inclination, vehicle.inclination) annotation (Line(points={{60,-120},
          {60,-14},{6,-14},{6,-12}},              color={0,0,127}));
  connect(vehicle.flangeR, multiSensorDrive.flange_b)
    annotation (Line(points={{10,0},{40,0}}, color={0,0,0}));
  connect(multiSensorDrive.flange_a, shaft)
    annotation (Line(points={{60,0},{100,0}}, color={0,0,0}));
  connect(multiSensorBike.power, energyBike.u)
    annotation (Line(points={{-44,11},{-44,30},{-32,30}}, color={0,0,127}));
  connect(multiSensorDrive.power, energyDrive.u)
    annotation (Line(points={{56,11},{56,30},{68,30}}, color={0,0,127}));
  connect(multiSensorBike.f, f) annotation (Line(points={{-50,11},{-50,80},{0,
          80},{0,110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
The trailer model consists of:
</p>
<ul>
<li>measurement of the force between bike and trailer: negative = trailer is braking</li>
<li>the <a href=\"modelica://Modelica.Mechanics.Translational.Components.Vehicle\">trailer</a></li>
<li>a shaft where to couple (conditionally) the drive.</li>
</ul>
</html>"));
end Trailer;
