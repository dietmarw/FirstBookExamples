within FirstBookExamples.Thermal;
package MixedDomain "Heat transfer components mixed with other domains"
  extends Modelica.Icons.Package;

  model HeaterElement "Heating element"
    extends Modelica.Electrical.Analog.Basic.Resistor;
    parameter Real efficiency=0.9
                                 "Efficiency of transformation";
    Interfaces.Node_a thermal annotation (Placement(transformation(
            extent={{-10,40},{10,60}})));
  equation
    thermal.q = -i^2*R*efficiency;
    annotation (
      Documentation(info="This heating element model allows energy in the electrical domain to manifest itself as thermal
energy.  The basic principle of the model is compute the power generated by the element (basic
on the resistance of the element) and to transform that power (subject to an efficiency factor)
into thermal energy.
"));
  end HeaterElement;

  model Thermocouple "Experimental thermocouple"
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter Real C[:] "Calibration coefficients";
    Interfaces.Node_a node_a annotation (Placement(transformation(
            extent={{-10,-110},{10,-90}})));
    function polyval
      extends Modelica.Icons.Function;
      input Real c[:];
      input Real u;
      output Real y;
    protected
      Integer n;
    algorithm
      n := size(c, 1);
      y := 0;
      for i in 1:n loop
        y := y + c[i]*u^(n - i);
      end for;
    end polyval;
  equation
    v = polyval(C, node_a.T);
    node_a.q = 0;
    annotation (
      Icon(graphics={
          Polygon(
            points={{-90,4},{-90,-4},{-8,-4},{-8,-90},{8,-90},{8,-4},
                {90,-4},{90,4},{-90,4}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-4,0},{-4,-90}}, color={0,0,0}),
          Line(points={{-90,0},{-4,0}}, color={0,0,0}),
          Line(points={{4,0},{90,0}}, color={0,0,0}),
          Line(points={{4,0},{4,-90}}, color={0,0,0}),
          Text(extent={{-100,40},{100,100}}, textString=
                                                 "%name")}),
      Documentation(info="This thermocouple is a model of a real-world experimental thermocouple.  It assumes that
the relationship between the voltage drop across the thermocouple (in the absence of any
electrical current flow) and the temperature of the thermocouple is governed by the
polynomial relationship:

V = sum(c_i*T^i)

The 'c' array is specified as a parameter of the thermocouple.  Because this emperical model
for thermocouple behavior is widely used, it should be possible to determine the values
for the 'c' array based on the published performance characteristics of thermocouples.
"));
  end Thermocouple;

  model RotationalSpring "Temperature sensitive rotational spring"
    extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
    parameter Real c(
      final unit="N.m/rad",
      final min=0) = 1 "Spring constant";
    parameter Modelica.SIunits.Temperature T_nom=273.15 "Nominal temperature";
    parameter Real dudT(final unit="rad/K") = 1.0
      "Angular expansion coefficient";
    parameter Modelica.SIunits.Angle unstretched_nom=0.0
      "Nominal unstretched length (at T_nom)";
    Modelica.SIunits.Angle phi_rel0(start=0) "Unstretched spring angle";
    Modelica.SIunits.Angle dphi "Delta phi";
    Modelica.SIunits.Energy P;
    Interfaces.Node_a node_a annotation (Placement(transformation(
            extent={{-10,50},{10,70}})));
  equation
    dphi = (phi_rel - phi_rel0);
    P = c*dphi^2;
    der(P) = node_a.q;
    phi_rel0 = unstretched_nom + dudT*(node_a.T - T_nom);
    tau = c*dphi;
    annotation (
      Icon(graphics={
          Line(
            points={{-100,0},{-60,0},{-44,-30},{-16,30},{17,-30},{47,
                30},{62,0},{100,0}},
            color={0,0,0},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None}),
          Line(points={{0,0},{0,50}}, color={255,0,0}),
          Text(extent={{-100,-100},{100,-40}}, textString=
                                                   "%name")}),
      Documentation(info="This rotational spring model takes into account the effect on the springs unstretched length due to
thermal expansion.  The spring is essentially a linear rotational spring just like the one provided
in the Modelica.Mechanics.Rotational library except that the unstretched length of the spring is
subject to thermal expansion.  The sensitivity of the unstretched length to temperature is given
by the 'dudT' parameter.
"));
  end RotationalSpring;
end MixedDomain;
