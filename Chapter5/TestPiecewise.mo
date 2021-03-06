model TestPiecewise 
  extends BookExamples.Icons.RunnableExample;
  import Modelica.SIunits;
  parameter SIunits.Time x_values[:]={0,2,4,6,8,10};
  parameter Real y_values[:]={0,0,4,16,36,64};
  Real y;
  Real x;
  Real z;
  annotation (experiment(StopTime=9.999),
              Commands(file="TestPiecewise.mos" "Simulate TestPiecewise"));
equation 
  y = Piecewise(x=time, x_grid=x_values, y_grid=y_values);
  der(x) = -y;
  der(z) = -x;
end TestPiecewise;
