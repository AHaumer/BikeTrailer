within BikeTrailer.Drives;
model DcdcConverter "Averaging dc/dc converter"
  extends Modelica.Blocks.Icons.Block;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin1;
  extends Modelica.Electrical.PowerConverters.Interfaces.DCDC.DCtwoPin2;
  parameter Modelica.Units.SI.Frequency fs=2e3 "Switching frequency";
  parameter Modelica.Units.SI.Time Ti=1e-6 "Integral time constant of power balance";
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensorBat annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Modelica.Electrical.Analog.Sensors.MultiSensor multiSensorMot annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-10})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,20})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Modelica.Blocks.Continuous.FirstOrder deadTime(
    k=1,
    T=0.5/fs,
    initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{10,-20},{30,0}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,20})));
  Modelica.Blocks.Continuous.Integrator integralController(k=1/Ti)
    annotation (Placement(transformation(extent={{-10,10},{-30,30}})));
  Modelica.Blocks.Continuous.FirstOrder currentSampler(
    k=1,
    T=0.5/fs,
    initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(transformation(extent={{10,-10},
            {-10,10}},
        rotation=90,
        origin={60,-80})));
  Modelica.Blocks.Interfaces.RealInput vRef annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealOutput vBat annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput iMot annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));
  Modelica.Blocks.Continuous.Integrator EBat
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
equation
  connect(multiSensorBat.pc, multiSensorBat.pv) annotation (Line(points={{-80,60},{-80,70},{-70,70}}, color={0,0,255}));
  connect(multiSensorBat.nc, signalCurrent.p) annotation (Line(points={{-60,60},{-50,60},{-50,30}}, color={0,0,255}));
  connect(multiSensorMot.pc, signalVoltage.p) annotation (Line(points={{60,60},{50,60},{50,0}}, color={0,0,255}));
  connect(signalVoltage.n, ground.p) annotation (Line(points={{50,-20},{50,-60}}, color={0,0,255}));
  connect(multiSensorMot.pc, multiSensorMot.pv) annotation (Line(points={{60,60},{60,70},{70,70}}, color={0,0,255}));
  connect(ground.p, multiSensorMot.nv) annotation (Line(points={{50,-60},{70,-60},{70,50}}, color={0,0,255}));
  connect(deadTime.y, signalVoltage.v) annotation (Line(points={{31,-10},{38,-10}}, color={0,0,127}));
  connect(variableLimiter.y, deadTime.u) annotation (Line(points={{6.66134e-16,-19},{6.66134e-16,-10},{8,-10}}, color={0,0,127}));
  connect(multiSensorBat.v, variableLimiter.limit1) annotation (Line(points={{-64,49},{-64,-52},{-8,-52},{-8,-42}}, color={0,0,127}));
  connect(multiSensorBat.v, gain.u) annotation (Line(points={{-64,49},{-64,-70},{-42,-70}}, color={0,0,127}));
  connect(gain.y, variableLimiter.limit2) annotation (Line(points={{-19,-70},{8,-70},{8,-42}}, color={0,0,127}));
  connect(signalCurrent.i, integralController.y)
    annotation (Line(points={{-38,20},{-31,20}}, color={0,0,127}));
  connect(integralController.u, feedback.y)
    annotation (Line(points={{-8,20},{11,20}}, color={0,0,127}));
  connect(multiSensorBat.power, feedback.u2) annotation (Line(points={{-81,54},{-90,54},{-90,40},{20,40},{20,28}}, color={0,0,127}));
  connect(multiSensorMot.power, feedback.u1) annotation (Line(points={{59,54},{40,54},{40,20},{28,20}}, color={0,0,127}));
  connect(currentSampler.u, multiSensorMot.i) annotation (Line(points={{60,-68},
          {60,0},{64,0},{64,49}},                                                                  color={0,0,127}));
  connect(multiSensorBat.pc, dc_p1) annotation (Line(points={{-80,60},{-96,
          60},{-96,62},{-100,62},{-100,60}}, color={0,0,255}));
  connect(dc_n1, multiSensorBat.nv) annotation (Line(points={{-100,-60},{
          -70,-60},{-70,50}}, color={0,0,255}));
  connect(dc_n1, signalCurrent.n) annotation (Line(points={{-100,-60},{-50,
          -60},{-50,10}}, color={0,0,255}));
  connect(multiSensorMot.nc, dc_p2)
    annotation (Line(points={{80,60},{100,60}}, color={0,0,255}));
  connect(ground.p, dc_n2)
    annotation (Line(points={{50,-60},{100,-60}}, color={0,0,255}));
  connect(vRef, variableLimiter.u)
    annotation (Line(points={{0,-120},{0,-42}}, color={0,0,127}));
  connect(multiSensorBat.v, vBat) annotation (Line(points={{-64,49},{-64,-70},{
          -60,-70},{-60,-110}}, color={0,0,127}));
  connect(currentSampler.y, iMot)
    annotation (Line(points={{60,-91},{60,-110}}, color={0,0,127}));
  connect(multiSensorBat.power, EBat.u) annotation (Line(points={{-81,54},{-90,
          54},{-90,40},{-20,40},{-20,60},{-12,60}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(points={{-100,-100},{100,100}}, color={0,0,255}),
        Text(
          extent={{-100,20},{-40,-20}},
          textColor={0,0,255},
          textString="Bat"),
        Text(
          extent={{40,20},{100,-20}},
          textColor={0,0,255},
          textString="Mot")}), Documentation(info="<html>
<p>
This is an averaging model of a dc/dc-converter, working with voltages and currents averaged over a switching period. 
The battery current is controlled by a fast integral controller ensuring power balance between battery and motor / machine. 
Compared with a time discrete control, dead time in applying voltage and measuring current is modeled with first order. 
</p>
</html>"));
end DcdcConverter;
