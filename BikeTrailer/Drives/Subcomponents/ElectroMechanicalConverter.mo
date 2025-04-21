within BikeTrailer.Drives.Subcomponents;
model ElectroMechanicalConverter
  "Converter between electrical DC and mechanical domian"
  parameter Modelica.Units.SI.MagneticFlux kPhi "Flux constant";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(transformation(extent={{-110,10},{-90,-10}})));
  Modelica.Units.SI.Voltage v=pin_p.v - pin_n.v "Voltage drop";
  Modelica.Units.SI.Current i=pin_p.i "Current through component";
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  Modelica.Units.SI.AngularVelocity w(displayUnit="rpm")=der(flange.phi -
    phi_support) "(Relative) shaft speed";
  Modelica.Units.SI.Torque tau=-flange.tau "Torque out of the component";
equation
  pin_p.i + pin_n.i = 0 "Current balance";
  v = kPhi*w "Faraday's law";
  tau = kPhi*i "Lorentz' force";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-10,-38},{10,-86}},
          lineColor={175,175,175},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{34,10},{100,-10}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          textColor={0,0,255},
          extent={{-150,-80},{150,-40}},
          textString="%name"),
        Ellipse(
          extent={{-36,36},{36,-36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,90},{0,0},{-90,0}},
                                      color={0,0,255})}),        Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This is a electro-mechanical converter, implementing Faraday's law (induced voltage in conductors moving in a magnetic field) 
and Lorentz' law (force on a current flowing through a magnetic field).
</p>
</html>"));
end ElectroMechanicalConverter;
