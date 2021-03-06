model TestComplexWave 
  extends BookExamples.Icons.RunnableExample;
  parameter ComplexWave.Data wdata(
    num=3, 
    a={1.3,2.2,5.8}, 
    f={2.0,3.0,7.0}, 
    phase={0,Modelica.Constants.pi,0});
  Real signal;
  constant Real pi=Modelica.Constants.pi;
  Real ver;
  annotation (experiment(StopTime=3),
              Commands(file="TestComplexWave.mos" "Simulate TestComplexWave"));
equation 
  signal = ComplexWave(time, wdata);
  ver = 1.3*Modelica.Math.sin(pi*2.0*time) + 2.2*Modelica.Math.sin(pi*3.0*time
     + pi) + 5.8*Modelica.Math.sin(pi*7.0*time);
end TestComplexWave;
