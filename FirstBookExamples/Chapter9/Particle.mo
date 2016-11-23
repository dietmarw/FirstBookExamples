within FirstBookExamples.Chapter9;
model Particle
  parameter Modelica.SIunits.Position x_init[3];
  parameter Modelica.SIunits.Velocity v_init[3];
protected
  outer function gravity
    extends GravityField;
  end gravity;
  Modelica.SIunits.Position x[3](start=x_init);
  Modelica.SIunits.Velocity v[3](start=v_init);
  Modelica.SIunits.Acceleration a[3];
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape p(
    shapeType="sphere",
    r=x,
    length=0.01,
    width=0.01,
    height=0.01);
equation
  v = der(x);
  a = der(v);
  a = gravity(x);
end Particle;
