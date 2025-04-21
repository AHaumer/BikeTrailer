within BikeTrailer.Components;
model GenericDrive "Generic drive for bike trailer"
  extends Modelica.Electrical.Machines.Icons.Drive;
  parameter Modelica.Units.SI.Time Tsub=1E-3
    "Substitute time constant of trailer drives(s)";
  parameter Modelica.Units.SI.Torque tauMax=30
    "Max. torque of trailer drives(s)";
  parameter Modelica.Units.SI.Torque tauMin=-30
    "Min. torque of trailer drives(s)";
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(
        transformation(
        extent={{20,-10},{40,10}},
        rotation=0)));
  Modelica.Blocks.Continuous.TransferFunction drive(
    b={1},
    a={Tsub^2/2,Tsub,1},
    initType=Modelica.Blocks.Types.Init.InitialOutput) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,30})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=tauMax, uMin=tauMin)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,70})));
  Modelica.Blocks.Interfaces.RealInput tauRef(unit="N.m")
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(torque.tau,drive. y) annotation (Line(points={{18,0},{0,0},{0,19}},
                             color={0,0,127}));
  connect(drive.u,limiter. y) annotation (Line(points={{0,42},{0,59}},
                            color={0,0,127}));
  connect(limiter.u,tauRef)
    annotation (Line(points={{0,82},{0,120}}, color={0,0,127}));
  connect(torque.flange, shaft)
    annotation (Line(points={{40,0},{100,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-120,-100},{120,-130}},
          textColor={28,108,200},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This is a generic drive, providing the demanded reference torque with limitation and delay, without considering field weakening.
It could be replaced by a real drive including electric machine, power electronics and current control.
</p>
</html>"));
end GenericDrive;
