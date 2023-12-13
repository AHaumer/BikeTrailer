within BikeTrailer.Components;
model Trailer "Model of a bike trailer"
  parameter DataRecords.Data data
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  parameter Boolean useWindInput=false "Enable signal input for wind velocity";
  parameter Modelica.Units.SI.Velocity vWindConstant=0 "Constant wind velocity"
    annotation(Dialog(enable=not useWindInput));
  parameter Boolean usecrInput=false "Enable signal input for rolling resistance coefficient";
  parameter Boolean useInclinationInput=false "Enable signal input for inclination";
  parameter Real inclinationConstant=0 "Constant inclination = tan(angle)"
    annotation(Dialog(enable=not useInclinationInput));
  Modelica.Units.SI.Position s(displayUnit="km", start=0)=vehicle.s "Position of trailer";
  Modelica.Units.SI.Velocity v(displayUnit="km/h", start=0)=vehicle.v "Velocity of trailer";
  Modelica.Mechanics.Translational.Interfaces.Flange_a flange
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Translational.Sensors.MultiSensor multiSensor
    annotation (Placement(transformation(extent={{-60,10},{-80,-10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={10,0})));
  Modelica.Blocks.Continuous.TransferFunction drive(
    b={1},
    a={data.Tsub^2/2,data.Tsub,1},
    initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={40,0})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=data.tauMax, uMin=data.tauMin)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealInput tauRef(unit="N.m")
                                              annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0})));
  Modelica.Mechanics.Translational.Components.Vehicle vehicle(
    m=data.m,
    J=data.J,
    R=data.D/2,
    A=data.A,
    Cd=data.cw,
    rho=data.rho,
    useWindInput=useWindInput,
    vWindConstant=vWindConstant,
    useCrInput=usecrInput,
    CrConstant=data.cr,
    useInclinationInput=useInclinationInput,
    inclinationConstant=inclinationConstant)
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealOutput f(unit="N") "Force" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
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
equation
  connect(flange, multiSensor.flange_b)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,0}));
  connect(multiSensor.flange_a, vehicle.flangeT)
    annotation (Line(points={{-60,0},{-40,0}}, color={0,127,0}));
  connect(vehicle.flangeR, torque.flange)
    annotation (Line(points={{-20,0},{0,0}}, color={0,0,0}));
  connect(torque.tau, drive.y) annotation (Line(points={{22,0},{25.5,0},{25.5,8.88178e-16},
          {29,8.88178e-16}}, color={0,0,127}));
  connect(drive.u, limiter.y) annotation (Line(points={{52,-1.9984e-15},{55.5,-1.9984e-15},
          {55.5,0},{59,0}}, color={0,0,127}));
  connect(limiter.u, tauRef)
    annotation (Line(points={{82,0},{120,0}}, color={0,0,127}));
  connect(multiSensor.f, f) annotation (Line(points={{-70,11},{-70,80},{0,80},{
          0,110}}, color={0,0,127}));
  connect(cr, vehicle.cr) annotation (Line(points={{0,-120},{0,-30},{-30,-30},{-30,
          -12}}, color={0,0,127}));
  connect(vWind, vehicle.vWind) annotation (Line(points={{-60,-120},{-60,-20},{-36,
          -20},{-36,-12}}, color={0,0,127}));
  connect(inclination, vehicle.inclination) annotation (Line(points={{60,-120},{
          60,-20},{-24,-20},{-24,-12},{-24,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-90,4},{-74,4},{-74,-10},{-56,-36},{-42,-36},{-42,-46},{-56,-46},
              {-82,-10},{-82,-6},{-90,-6},{-90,4}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={175,175,175}),
        Polygon(
          points={{-60,-20},{80,-20},{60,-60},{-40,-60},{-60,-20}},
          lineColor={28,108,200},
          fillColor={0,255,128},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{80,-20},{80,0},{58,60},{20,60},{-60,-20},{80,-20}},
          lineColor={28,108,200},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,100},{100,60}},
          textColor={28,108,200},
          textString="%name"),
        Ellipse(
          extent={{0,-42},{60,-100}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere)}),                     Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Trailer;
