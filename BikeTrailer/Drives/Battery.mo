within BikeTrailer.Drives;
model Battery "Simple battery model"
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  Modelica.Units.SI.Current i=p.i "Current consumed by battery";
  parameter Modelica.Units.SI.Voltage Voc=60 "Open circuit voltage at SOC=1";
  parameter Modelica.Units.SI.Voltage Vmin=48 "Minimum open-circuit voltage at SOCmin";
  parameter Modelica.Units.SI.Current Isc=250 "Short-circuit current at SOC=1";
  parameter Modelica.Units.SI.ElectricCharge Qnom(displayUnit="A.h")=20*3600 "Nominal (maximum) charge";
  Modelica.Units.SI.Power power=v*i "Power consumed by battery";
  Real SOC(start=1, unit="1")=soc.y "State of charge";
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=Voc/Isc)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Continuous.Integrator soc(k=1/Qnom,
                                            initType=Modelica.Blocks.Types.Init.NoInit)
                                            annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,30})));
  Subcomponents.Soc2v soc2v(Voc=Voc, Vmin=Vmin) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
equation
  connect(p, currentSensor.p)
    annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
  connect(currentSensor.n, signalVoltage.p)
    annotation (Line(points={{-30,0},{-10,0}}, color={0,0,255}));
  connect(signalVoltage.n, resistor.p)
    annotation (Line(points={{10,0},{40,0}}, color={0,0,255}));
  connect(resistor.n, n)
    annotation (Line(points={{60,0},{100,0}}, color={0,0,255}));
  connect(soc.u, currentSensor.i)
    annotation (Line(points={{-40,18},{-40,11}}, color={0,0,127}));
  connect(soc2v.y, signalVoltage.v)
    annotation (Line(points={{0,19},{0,12}}, color={0,0,127}));
  connect(soc.y, soc2v.u) annotation (Line(points={{-40,41},{-40,50},{0,50},{0,42}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-90,30},{-100,30},{-110,10},{-110,-10},{-100,-30},{-90,-30},{
              -90,30}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{90,40},{110,-40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,60},{90,-60}},
          lineColor={0,0,255},
          radius=10),
        Rectangle(
          extent={{70,-40},{-70,40}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,70},{150,110}},
          textColor={0,0,255},
          textString="%name")}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
A simple battery model: SOC (state of charge) is tracked by measuring the current and integrating to achieve charge. 
For simplicity reasons the prescribed open-circuit voltage depends linearly on state of charge between 
<code>Voc</code> at <code>SOC=1</code> and <code>Vmin</code> at <code>SOCmin</code>. 
Additionally the internal resistance (computed from short-circuit current <code>Isc</code> at <code>SOC=1</code>) is taken into account.
</p>
</html>"));
end Battery;
