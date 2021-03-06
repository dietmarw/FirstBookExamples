model BouncingBall3 
  extends BookExamples.Icons.RunnableExample;
  import Modelica.SIunits;
  
  parameter SIunits.Mass m=1 "Mass of the ball";
  parameter Real c_r=0.725 "Coefficient of restitution";
  parameter SIunits.Radius r=1e-3 "Radius of the ball";
  
  SIunits.Height h(start=5.0) "Height of the ball center";
  SIunits.Velocity v "Velocity of the ball";
  SIunits.Acceleration a "Acceleration of the ball";
  Boolean bouncing(start=true) "Is the ball to still be bouncing?";
  Boolean impact "Indicates when impact occurs";
  annotation (experiment(StopTime=25),
              Commands(file="BouncingBall3.mos" "Simulate BouncingBall3"));
equation 
  v = der(h);
  a = der(v);
  m*a = if bouncing then -m*Modelica.Constants.g_n else 0;
algorithm 
  impact := h <= r;
  when {impact,impact and v <= 0} then
    if edge(impact) then
      bouncing := pre(v) <= 0;
      reinit(v, -c_r*pre(v));
    else
      reinit(v, 0.0);
      bouncing := false;
    end if;
  end when;
end BouncingBall3;
