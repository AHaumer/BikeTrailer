within BikeTrailer.Components;
model DcpmDrive "Complete drive with dcpm"
  extends Modelica.Electrical.Machines.Icons.Drive;
  Real SOC(start=1)=battery.SOC "State of charge";
  Modelica.Units.SI.Power PBat=dcdcConverter.multiSensorBat.power "Power consumption from battery";
  Modelica.Units.SI.Energy EBat=dcdcConverter.EBat.y "Energy consumption from battery";
  Drives.Dcpm dcpm(dcpmData=driveData.dcpmData, ia(fixed=true))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Drives.DcdcConverter dcdcConverter(fs=driveData.fs) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
  Drives.Battery battery(
    Voc=driveData.VBat,
    Vmin=driveData.Vmin,
    Isc=driveData.IBat,
    Qnom=driveData.QBat)
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,50})));
  parameter DataRecords.DriveData driveData
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Machines.Examples.ControlledDCDrives.Utilities.LimitedPI
    limitedPI(
    k=driveData.kpI,
    Ti=driveData.TiI,
    useFF=true,
    KFF=driveData.dcpmData.kPhi,
    constantLimits=false,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Blocks.Interfaces.RealInput tauRef(unit="N.m")
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Math.Gain tau2i(k=1/driveData.dcpmData.kPhi)
    annotation (Placement(transformation(extent={{-30,70},{-50,90}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=driveData.IaMax) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-70,50})));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=driveData.ratio)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(dcdcConverter.dc_n2, dcpm.pin_n)
    annotation (Line(points={{-6,20},{-6,10}}, color={0,0,255}));
  connect(dcdcConverter.dc_p2, dcpm.pin_p)
    annotation (Line(points={{6,20},{6,10}}, color={0,0,255}));
  connect(battery.n, ground.p)
    annotation (Line(points={{-10,60},{-20,60},{-20,50}}, color={0,0,255}));
  connect(ground.p, dcdcConverter.dc_n1)
    annotation (Line(points={{-20,50},{-6,50},{-6,40}}, color={0,0,255}));
  connect(battery.p, dcdcConverter.dc_p1) annotation (Line(points={{10,60},{20,60},
          {20,50},{6,50},{6,40}}, color={0,0,255}));
  connect(dcdcConverter.vBat, limitedPI.yMaxVar)
    annotation (Line(points={{-11,36},{-28,36}}, color={0,0,127}));
  connect(limitedPI.y, dcdcConverter.vRef)
    annotation (Line(points={{-29,30},{-12,30}}, color={0,0,127}));
  connect(dcpm.w, limitedPI.feedForward)
    annotation (Line(points={{-11,0},{-40,0},{-40,18}}, color={0,0,127}));
  connect(limitedPI.u_m, dcdcConverter.iMot) annotation (Line(points={{-46,18},{
          -46,10},{-20,10},{-20,24},{-11,24}}, color={0,0,127}));
  connect(tauRef, tau2i.u)
    annotation (Line(points={{0,120},{0,80},{-28,80}}, color={0,0,127}));
  connect(limiter.y, limitedPI.u)
    annotation (Line(points={{-70,39},{-70,30},{-52,30}}, color={0,0,127}));
  connect(tau2i.y, limiter.u)
    annotation (Line(points={{-51,80},{-70,80},{-70,62}}, color={0,0,127}));
  connect(idealGear.flange_b, shaft)
    annotation (Line(points={{60,0},{100,0}}, color={0,0,0}));
  connect(idealGear.flange_a, dcpm.shaft)
    annotation (Line(points={{40,0},{10,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
        Line(points={{-80,36},{-60,36}}, color={0,0,0}),                  Text(
          extent={{-120,-100},{120,-130}},
          textColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DcpmDrive;
