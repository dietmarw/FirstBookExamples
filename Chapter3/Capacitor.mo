model Capacitor "An electrical capacitor" 
  import Modelica.SIunits;
  
  parameter SIunits.Capacitance C=1e-6 "Capacitance";
  ElectricalPin p annotation (extent=[-110, -10; -90, 10]);
  ElectricalPin n annotation (extent=[90, -10; 110, 10]);
  SIunits.Voltage v;
equation 
  v = p.v - n.v;
  p.i = C*der(v);
  p.i + n.i = 0;
end Capacitor;
