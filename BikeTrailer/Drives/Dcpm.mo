within BikeTrailer.Drives;
model Dcpm "Permanent magnet excited dc machine"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;
  replaceable parameter BikeTrailer.DataRecords.DCPM.DcpmData dcpmData
    constrainedby BikeTrailer.DataRecords.DCPM.DcpmData annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-90,70},{-70,90}})));
  Modelica.Units.SI.Voltage va=pin_p.v - pin_n.v "Armature voltage";
  Modelica.Units.SI.Current ia(start=0)=pin_p.i "Armature current";
  extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
  Modelica.Units.SI.Angle phi(start=0)=shaft.phi "Mechnical shaft angle";
  Modelica.Units.SI.Torque tau=inertiaRotor.flange_a.tau "Inner torque";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{50,110},{70,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{-70,110},{-50,90}})));
  Subcomponents.ElectroMechanicalConverter electroMechanicalConverter(kPhi=
        dcpmData.kPhi, useSupport=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Resistor armatureResistance(
    R=dcpmData.Ra,
    T_ref=dcpmData.TaRef,
    alpha=dcpmData.alpha20a,
    useHeatPort=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,60})));
  Modelica.Electrical.Analog.Basic.Inductor armatureInductance(L=dcpmData.La)
    annotation (Placement(transformation(extent={{40,20},{20,40}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(J=dcpmData.Jr)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput w(
    unit="rad/s",
    displayUnit="rpm",
    start=0) "Mechanical shaft speed"
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={52,-10})));
equation
  connect(pin_p, armatureResistance.p)
    annotation (Line(points={{60,100},{60,70}}, color={0,0,255}));
  connect(armatureResistance.n, armatureInductance.p)
    annotation (Line(points={{60,50},{60,30},{40,30}}, color={0,0,255}));
  connect(electroMechanicalConverter.pin_p, armatureInductance.n)
    annotation (Line(points={{0,10},{0,30},{20,30}}, color={0,0,255}));
  connect(electroMechanicalConverter.pin_n, pin_n) annotation (Line(points={{-10,
          0},{-20,0},{-20,30},{-60,30},{-60,100}}, color={0,0,255}));
  connect(inertiaRotor.flange_b,shaft)
    annotation (Line(points={{40,0},{100,0}}, color={0,0,0}));
  connect(electroMechanicalConverter.flange, inertiaRotor.flange_a)
    annotation (Line(points={{10,0},{20,0}}, color={0,0,0}));
  connect(armatureResistance.heatPort, internalHeatPort) annotation (Line(
        points={{70,60},{80,60},{80,-60},{0,-60},{0,-80}}, color={191,0,0}));
  connect(inertiaRotor.flange_b, speedSensor.flange)
    annotation (Line(points={{40,0},{52,0}}, color={0,0,0}));
  connect(speedSensor.w, w) annotation (Line(points={{52,-21},{52,-30},{-80,-30},
          {-80,0},{-110,0}}, color={0,0,127}));
  annotation (Icon(graphics={Line(points={{-60,90},{-60,80},{-20,80},{-20,70}},
            color={28,108,200}), Line(points={{60,90},{60,80},{20,80},{20,70}},
            color={28,108,200}),
        Rectangle(
          extent={{-80,40},{-60,-40}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(points={{-80,-36},{-60,-36}}, color={0,0,0}),
        Line(points={{-80,-30},{-60,-30}}, color={0,0,0}),
        Line(points={{-80,-20},{-60,-20}}, color={0,0,0}),
        Line(points={{-80,-10},{-60,-10}}, color={0,0,0}),
        Line(points={{-80,0},{-60,0}}, color={0,0,0}),
        Line(points={{-80,10},{-60,10}}, color={0,0,0}),
        Line(points={{-80,20},{-60,20}}, color={0,0,0}),
        Line(points={{-80,30},{-60,30}}, color={0,0,0}),
        Line(points={{-80,36},{-60,36}}, color={0,0,0})}), Documentation(
        info="<html>
<p>
This is a simplified model of a permanent magnet excited DC machine. 
All losses except ohmic losses of the armature winding are neglected. 
The armature resistance is dependent on temperature. 
Additionally, the armature inductance is implemented. 
Induced voltage and generated torque are calculated in the electro-mechanical converter. 
By extending from the PartialMachine, shaft flange, inertia of stator and rotor as well as 
a conditional support/housing flange and a conditional thermal connector are inherited.
</p>
</html>"));
end Dcpm;
