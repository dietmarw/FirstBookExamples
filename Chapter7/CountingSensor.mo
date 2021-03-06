model CountingSensor 
  import Modelica.Mechanics.Rotational;
  
  extends Rotational.Interfaces.AbsoluteSensor;
  parameter Integer divisions=4;
  parameter Modelica.SIunits.Time sample_interval=0.1;
protected 
  constant Real pi=Modelica.Constants.pi;
  parameter Modelica.SIunits.Angle trigger_interval=2*pi/divisions;
  Integer count;
  Real s;
equation 
  flange_a.tau = 0;
  s = Modelica.Math.sin(flange_a.phi*divisions);
algorithm 
  when initial() then
    count := 0;
  end when;
  when s >= 0 then
    count := pre(count) + 1;
  end when;
  when sample(sample_interval, sample_interval) then
    count := 0;
    outPort.signal[1] := (pre(count) + 1)*trigger_interval/sample_interval;
  end when;
end CountingSensor;
