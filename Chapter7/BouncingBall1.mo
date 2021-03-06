model BouncingBall1 
  extends BookExamples.Icons.RunnableExample;
  import Modelica.SIunits;
  
  parameter SIunits.Mass m=1.0 "Mass of the ball";
  parameter Real c(final unit="N/m") = 1e+4 "Compliance";
  parameter Real d(final unit="N/(m.s)") = 20 "Damping";
  parameter SIunits.Radius r=0.02 "Radius of the ball";
  
  SIunits.Height h(start=5.0) "Height of the ball center";
  SIunits.Velocity v "Velocity of the ball";
  SIunits.Acceleration a "Acceleration of the ball";
  SIunits.Force f "Force on the ball";
  annotation (experiment(StopTime=5),
              Commands(file="BouncingBall1.mos" "Simulate BouncingBall1"));
equation 
  v = der(h);
  a = der(v);
  m*a = f - m*Modelica.Constants.g_n;
  f = if h <= r then -c*(h - r) - d*v else 0.0;
end BouncingBall1;
