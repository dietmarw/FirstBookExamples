within FirstBookExamples.Chapter9;
model ParticleField
  extends FirstBookExamples.Icons.RunnableExample;
  inner function gravity
    extends TwoBodyField;
  end gravity;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape b1(
    shapeType="sphere",
    r={0,0,0},
    length=0.05,
    width=0.05,
    height=0.05);
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape b2(
    shapeType="sphere",
    r={0,1,0},
    length=0.05,
    width=0.05,
    height=0.05);
  Particle p1(x_init={2,-2,0}, v_init={0.7,0,0});
  Particle p2(x_init={0,0.5,0}, v_init={-1,-1,0});
  Particle p3(x_init={0.5,2,0}, v_init={-1,-0.5,0});
  annotation (experiment(
      StopTime=5,
      Tolerance=1e-8,
      NumberOfIntervals=500),
      __Dymola_Commands(file="ParticleField.mos" "Simulate ParticleField"));
end ParticleField;
