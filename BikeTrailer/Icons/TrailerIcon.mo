within BikeTrailer.Icons;
partial model TrailerIcon "Icon of a trailer"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-90,4},{-74,4},{-74,-10},{-56,-36},{-42,-36},{-42,-46},{-56,
              -46},{-82,-10},{-82,-6},{-90,-6},{-90,4}},
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
          fillPattern=FillPattern.Sphere)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end TrailerIcon;
