within BikeTrailer.Components;
model Vehicle "Simple vehicle model"
  parameter Modelica.Units.SI.Mass m "Total mass of vehicle";
  parameter Modelica.Units.SI.Acceleration g=Modelica.Constants.g_n
    "Constant gravity acceleration";
  parameter Modelica.Units.SI.Inertia J
    "Total rotational inertia of drive train";
  parameter Modelica.Units.SI.Length R "Wheel radius";
  parameter Modelica.Units.SI.Area A(start=1) "Cross section of vehicle"
    annotation (Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter Real Cd(start=0.5) "Drag resistance coefficient"
    annotation(Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter Modelica.Units.SI.Density rho=1.2 "Density of air"
    annotation (Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter Boolean useWindInput=false "Enable signal input for wind velocity"
    annotation(Dialog(tab="Driving resistances", group="Drag resistance"));
  parameter Modelica.Units.SI.Velocity vWindConstant=0 "Constant wind velocity"
    annotation (Dialog(
      tab="Driving resistances",
      group="Drag resistance",
      enable=not useWindInput));
  parameter Boolean useCrInput=false "Enable signal input for Cr"
    annotation(Dialog(tab="Driving resistances", group="Rolling resistance"));
  parameter Real CrConstant=0.015 "Constant rolling resistance coefficient"
    annotation(Dialog(tab="Driving resistances", group="Rolling resistance", enable=not useCrInput));
  parameter Modelica.Units.SI.Velocity vReg=1e-3
    "Velocity for regularization around 0"
    annotation (Dialog(tab="Driving resistances", group="Rolling resistance"));
  parameter Boolean useInclinationInput=false "Enable signal input for inclination"
    annotation(Dialog(tab="Driving resistances", group="Inclination resistance"));
  parameter Real inclinationConstant=0 "Constant inclination = tan(angle)"
    annotation(Dialog(tab="Driving resistances", group="Inclination resistance", enable=not useInclinationInput));
  Modelica.Units.SI.Position s(
    displayUnit="km",
    start=0)=mass.s "Position of vehicle";
  Modelica.Units.SI.Velocity v(
    displayUnit="km/h",
    start=0)=mass.v "Velocity of vehicle";
  Modelica.Units.SI.Acceleration a=mass.a "Acceleration of vehicle";
protected
  constant Modelica.Units.SI.Velocity vRef=1 "Reference velocity for air drag";
public
  Modelica.Mechanics.Translational.Sources.QuadraticSpeedDependentForce fDrag(
    final useSupport=true,
    final f_nominal=-Cd*A*rho*vRef^2/2,
    final ForceDirection=false,
    final v_nominal=vRef) "Drag resistance"
    annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
  Modelica.Mechanics.Translational.Sources.Force fGrav "Inclination resistance"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,60})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT "Translational flange"
    annotation (Placement(transformation(extent={{90,10},{110,-10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flangeR "Rotational flange"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(final J=J)
    annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  Modelica.Mechanics.Translational.Components.IdealRollingWheel idealRollingWheel(final
      radius=R)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  Modelica.Mechanics.Translational.Components.Mass mass(final m=m)
    annotation (Placement(transformation(extent={{50,80},{70,100}})));
  Modelica.Blocks.Interfaces.RealInput inclination if useInclinationInput
    "Inclination=tan(angle)"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Blocks.Interfaces.RealInput cr if useCrInput
    "Rolling resistance coefficient"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput vWind(unit="m/s") if useWindInput
    "Wind velocity"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-120})));
  Modelica.Mechanics.Translational.Sources.Speed windSpeed(s(fixed=true))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-70})));
  Modelica.Blocks.Math.Gain gravForceGain(final k=-m*g) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={-10,60})));
protected
  Modelica.Blocks.Sources.Constant constInclination(k=inclinationConstant)
    if not useInclinationInput
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-80,-90})));
  Modelica.Blocks.Sources.Constant constWindSpeed(k=vWindConstant) if not useWindInput
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={40,-90})));
  Modelica.Blocks.Sources.Constant constCr(k=CrConstant)
    if not useCrInput annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, origin={-20,-90})));
protected
  Modelica.Blocks.Interfaces.RealInput cr_internal
    "Rolling resistance coefficient" annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={0,-80}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={0,-80})));
public
  Modelica.Blocks.Math.Atan atan annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,-70},
        rotation=90)));
  Modelica.Blocks.Math.Sin sin annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, origin={-38,60})));
  Modelica.Blocks.Math.Cos cos annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, origin={-40,30})));
  Modelica.Blocks.Math.Gain contactForce(final k=-m*g) annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={-10,30})));
  Modelica.Mechanics.Translational.Sources.Force fRoll "Rolling resistance"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,
            30})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(extent={{70,-30},{50,-10}})));
  Modelica.Blocks.Math.Gain regularization(final k=1/vReg) annotation (
      Placement(transformation(extent={{10,-10},{-10,10}}, origin={30,-20})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=+1, uMin=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={10,-2})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{20,40},{40,20}})));
equation
  connect(idealRollingWheel.flangeT, mass.flange_a)
    annotation (Line(points={{10,90},{50,90}},
                                             color={0,127,0}));
  connect(constWindSpeed.y, windSpeed.v_ref)
    annotation (Line(points={{51,-90},{60,-90},{60,-82}}, color={0,0,127}));
  connect(vWind, windSpeed.v_ref)
    annotation (Line(points={{60,-120},{60,-82}}, color={0,0,127}));
  connect(fDrag.support, windSpeed.flange)
    annotation (Line(points={{60,-50},{60,-60}}, color={0,127,0}));
  connect(mass.flange_b, flangeT) annotation (Line(points={{70,90},{80,90},{80,
          0},{100,0}},
                    color={0,127,0}));
  connect(sin.u, atan.y)
    annotation (Line(points={{-50,60},{-60,60},{-60,-59}},
                                                   color={0,0,127}));
  connect(gravForceGain.u, sin.y) annotation (Line(points={{-22,60},{-27,60}}, color={0,0,127}));
  connect(gravForceGain.y, fGrav.f)
    annotation (Line(points={{1,60},{48,60}},  color={0,0,127}));
  connect(mass.flange_b, fDrag.flange) annotation (Line(points={{70,90},{80,90},
          {80,-40},{70,-40}},     color={0,127,0}));
  connect(mass.flange_b, fGrav.flange) annotation (Line(points={{70,90},{80,90},
          {80,60},{70,60}},     color={0,127,0}));
  connect(inertia.flange_b, idealRollingWheel.flangeR)
    annotation (Line(points={{-30,90},{-10,90}}, color={0,0,0}));
  connect(flangeR, inertia.flange_a) annotation (Line(points={{-100,0},{-80,0},
          {-80,90},{-50,90}},color={0,0,0}));
  connect(inclination, atan.u) annotation (Line(points={{-60,-120},{-60,-82}},
                     color={0,0,127}));
  connect(atan.u, constInclination.y) annotation (Line(points={{-60,-82},{-60,
          -90},{-69,-90}},              color={0,0,127}));
  connect(atan.y, cos.u)
    annotation (Line(points={{-60,-59},{-60,30},{-52,30}},
                                                         color={0,0,127}));
  connect(cos.y, contactForce.u)
    annotation (Line(points={{-29,30},{-22,30}}, color={0,0,127}));
  connect(flangeT, fRoll.flange) annotation (Line(points={{100,0},{80,0},{80,30},
          {70,30}}, color={0,127,0}));
  connect(flangeT, speedSensor.flange) annotation (Line(points={{100,0},{80,0},
          {80,-20},{70,-20}}, color={0,127,0}));
  connect(speedSensor.v, regularization.u)
    annotation (Line(points={{49,-20},{42,-20}}, color={0,0,127}));
  connect(cr, cr_internal)
    annotation (Line(points={{0,-120},{0,-80}}, color={0,0,127}));
  connect(constCr.y, cr_internal)
    annotation (Line(points={{-9,-90},{0,-90},{0,-80}}, color={0,0,127}));
  connect(multiProduct.y, fRoll.f)
    annotation (Line(points={{41.7,30},{48,30}}, color={0,0,127}));
  connect(regularization.y, limiter.u)
    annotation (Line(points={{19,-20},{10,-20},{10,-14}}, color={0,0,127}));
  connect(contactForce.y, multiProduct.u[1]) annotation (Line(points={{1,30},{8,
          30},{8,32.3333},{20,32.3333}}, color={0,0,127}));
  connect(cr_internal, multiProduct.u[2]) annotation (Line(points={{0,-80},{0,
          20},{10,20},{10,30},{20,30}}, color={0,0,127}));
  connect(limiter.y, multiProduct.u[3]) annotation (Line(points={{10,9},{10,18},
          {14,18},{14,27.6667},{20,27.6667}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Polygon(points={{-70,15},{-70,-25},{50,-25},{50.6257,-4.24762},{21.6479,
              3.51695},{10.8518,25.0447},{-60,25},{-70,15}},
      lineColor={0,127,0}, fillColor={160,215,160}, fillPattern=FillPattern.Solid, origin={0,-9}, rotation=15),
    Line(points={{-80,-70},{80,-70}}, color={0,127,0}),
    Line(points={{-80,0},{85.607,-1.19754}},
      color={0,127,0}, origin={-3,-49}, rotation=15),
    Ellipse(extent={{-130,-120},{-30,-20}}, lineColor={0,127,0},
      startAngle=0, endAngle=15,
      closure=EllipseClosure.None),
    Line(points={{-40,0},{40,0}}, color={95,127,95}, origin={-40,32}, rotation=15),
    Polygon(points={{15,0},{-15,10},{-15,-10},{15,0}}, lineColor={95,127,95}, fillColor={95,127,95},
      fillPattern = FillPattern.Solid, origin={11,46}, rotation=15),
    Text(extent={{-150,100},{150,60}}, textString="%name", textColor={0,0,255}),
    Polygon(points={{-20,0},{0,10},{0,4},{20,4},{20,-4},{0,-4},{0,-10},{-20,0}}, lineColor={0,127,0}, fillColor={160,215,160},
      fillPattern = FillPattern.Solid, origin={68,18}, rotation=15),
    Text(
      extent={{-80,-80},{-40,-100}},
      textColor={64,64,64},
      textString="inc."),
    Text(
      extent={{-20,-80},{20,-100}},
      textColor={64,64,64},
      textString="cr"),
    Text(
      extent={{30,-80},{90,-100}},
      textColor={64,64,64},
      textString="wind"),
    Ellipse(extent={{-50,-34},{-26,-58}},lineColor={0,127,0}, fillPattern=FillPattern.Sphere, fillColor={160,215,160}),
    Ellipse(extent={{20,-16},{44,-40}},  lineColor={0,127,0}, fillPattern=FillPattern.Sphere, fillColor={160,215,160}),
    Ellipse(extent={{26,-22},{38,-34}},  lineColor={0,127,0}, fillPattern=FillPattern.Solid,
      fillColor={255,255,255}),
    Ellipse(extent={{-44,-40},{-32,-52}},lineColor={0,127,0}, fillPattern=FillPattern.Solid,
      fillColor={255,255,255})}),
    Documentation(info="<html>
<p>
This is a simple model of a&nbsp;ground vehicle, comprising the mass, the aerodynamic drag, the rolling resistance and
the inclination resistance (caused by the road grade).
For all particular resistances, significant variables can be either given by a&nbsp;parameter or input by a&nbsp;time-variable signal.
</p>
<p>
The vehicle can be driven at the rotational flange <code>flangeR</code>, e.g. by an electric motor and a&nbsp;gearbox.
It is possible to use the vehicle as a&nbsp;passive trailer, leaving the rotational flange <code>flangeR</code> unconnected.
</p>
<p>
At the translational flange <code>flangeT</code> the vehicle can be coupled with another vehicle,
e.g. as a&nbsp;trailer or to pull a&nbsp;trailer.
It is possible to leave the translational flange <code>flangeT</code> unconnected.
</p>
<p>
The velocity&nbsp;<code>v</code> and the driven distance&nbsp;<code>s</code> of the vehicle are provided as variables;
the vehicle can be initialized using these variables.
</p>

<h4>Mass and inertia</h4>
<p>
Both the translational vehicle mass and the rotational inertias (e.g. the wheels)
are accelerated when the vehicle is accelerated.
This nature is usually put into account for fundamental vehicle analyses
done either in the rotational or translational domain, e.g. when analysing
vehicle&apos;s driveline.
Then, the vehicle mass&nbsp;<code>m</code> can be expressed as an additional
equivalent inertia <code>J_eq&nbsp;=&nbsp;m&nbsp;*&nbsp;R<sup>2</sup></code> or
vice versa rotational inertia&nbsp;<code>J</code> as an additional
equivalent mass <code>m_eq&nbsp;=&nbsp;J/R<sup>2</sup></code>,
where&nbsp;<code>R</code> is the wheel radius.
Since this model introduces rolling resistance and inclination resistance as well
where just the vehicle mass plays a&nbsp;role,
the approach of equivalent mass/inertia would lead to incorrect simulation results
and shall therefore not be applied here.
</p>

<h4>Drag resistance</h4>
<blockquote>
<pre>
fDrag = Cd*rho*A*(v - vWind)^2/2
</pre>
</blockquote>
<p>
Wind velocity is measured in the same direction as velocity of <code>flangeT</code>.
Wind velocity is either constant or prescribed by the input <code>vWind</code>.
</p>

<h4>Rolling resistance</h4>
<blockquote>
<pre>
fRoll = Cr*m*g*cos(alpha)
</pre>
</blockquote>
<p>
Rolling resistance coefficient&nbsp;<var>Cr</var> is either constant
or prescribed by the input <code>cr</code>.
Rolling resistance has a&nbsp;crossover from positive to negative velocity within <code>[-vReg,&nbsp;vReg]</code>.
</p>
<p>
The inclination angle&nbsp;<var>&alpha;</var> is either constant or prescribed by
the input <code>inclination</code> = tan(<var>&alpha;</var>).
This corresponds to the road rise over running distance of 100&nbsp;m which,
in general, is written as a&nbsp;percentage.
For example for a&nbsp;road rising by 10&nbsp;m over 100&nbsp;m the
grade&nbsp;=&nbsp;10&nbsp;% and, thus, the parameter
<code>inclinationConstant&nbsp;=&nbsp;0.1</code>.
Positive inclination means driving uphill, negative inclination means
driving downhill, in case of positive vehicle velocity.
</p>

<h4>Inclination resistance</h4>
<blockquote>
<pre>
fGrav = m*g*sin(alpha)
</pre>
</blockquote>
<p>
With the inclination angle&nbsp;<var>&alpha;</var> described above.
</p>
</html>"));
end Vehicle;
