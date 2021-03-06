package HodgkinHuxley 
  package SIunits = Modelica.SIunits;
  type ConductanceDensity = Real (final quantity="ConductanceDensity", final 
        unit="Ohm-1/m2");
  type CapacitanceDensity = Real (final quantity="CapacitanceDensity", final 
        unit="F/m2");
  type MilliVoltage = Real (final quantity="Voltage", final unit="mV");
  
  constant CapacitanceDensity C_m=1e-2 "Membrance Capacitance";
  constant ConductanceDensity G_Na=1200 "Sodium Conductance";
  constant ConductanceDensity G_K=360 "Potassium Conductance";
  constant ConductanceDensity G_L=3 "Leakage conductance";
  constant SIunits.Voltage E_Na=50e-3 "Sodium potential";
  constant SIunits.Voltage E_K=-77e-3 "Potassium potential";
  constant SIunits.Voltage E_L=-54.4e-3 "Leakage potential";
  
  model MembraneCapacitance 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Area membrane_area;
  protected 
    Modelica.SIunits.Capacitance C=membrane_area*C_m;
    annotation (
      Icon(
        Line(points=[-20, 0; -100, 0], style(color=0)), 
        Line(points=[-20, 60; -20, -60], style(color=0)), 
        Line(points=[20, 60; 20, -60], style(color=0)), 
        Line(points=[20, 0; 100, 0], style(color=0))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.39, 
        y=0.39, 
        width=0.6, 
        height=0.6));
  equation 
    i = C*der(v);
  end MembraneCapacitance;
  
  model SodiumChannel "Hodgkin-Huxley Sodium Channel" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Area membrane_area;
  protected 
    constant MilliVoltage V_am=40;
    constant MilliVoltage V_bm=65;
    constant MilliVoltage V_ah=65;
    constant MilliVoltage V_bh=35;
    Real m_prob "Probability of activation of channel";
    Real h_prob "Probability of inactivation of channel";
    SIunits.DecayConstant a_m;
    SIunits.DecayConstant b_m;
    SIunits.DecayConstant a_h;
    SIunits.DecayConstant b_h;
    SIunits.Conductance G;
    MilliVoltage E=1000*v;
    parameter SIunits.Conductance g_max=membrane_area*G_Na;
    annotation (
      Icon(
        Line(points=[-98, 0; -80, 0; -70, 20; -60, -20; -50, 20; -40, -20; -30, 
               20; -20, -20; -10, 20; 0, -20; 10, 20; 20, 0; 40, 0], style(
              color=0)), 
        Line(points=[40, 60; 40, -60], style(color=0)), 
        Line(points=[50, 30; 50, -30], style(color=0)), 
        Line(points=[50, 0; 100, 0], style(color=0)), 
        Line(points=[0, -30; -60, 32], style(color=0)), 
        Line(points=[-60, 32; -54, 32], style(color=0)), 
        Line(points=[-60, 32; -60, 26], style(color=0)), 
        Text(extent=[60, 40; 100, 20], string="Na")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.16, 
        y=0.14, 
        width=0.6, 
        height=0.6));
  equation 
    G = m_prob^3*h_prob*g_max;
    i = G*(v - E_Na);
    der(m_prob) = 1000*(a_m*(1 - m_prob) - b_m*m_prob);
    a_m = (.1*(E + V_am))/(1 - Modelica.Math.exp(-(E + V_am)/10));
    b_m = 4*Modelica.Math.exp(-(E + V_bm)/18);
    der(h_prob) = 1000*(a_h*(1 - h_prob) - b_h*h_prob);
    a_h = .07*Modelica.Math.exp(-(E + V_ah)/20);
    b_h = 1/(1 + Modelica.Math.exp(-(E + V_bh)/10));
  end SodiumChannel;
  
  model PotassiumChannel "Hodgkin-Huxley Potassium Channel" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Area membrane_area;
    Real n_prob "Probability of activation of channel";
  protected 
    parameter SIunits.Conductance g_max=membrane_area*G_K;
    constant MilliVoltage V_an=55;
    constant MilliVoltage V_bn=65;
    SIunits.DecayConstant a_n;
    SIunits.DecayConstant b_n;
    SIunits.Conductance G;
    MilliVoltage E=1000*v;
    annotation (
      Icon(
        Line(points=[-98, 0; -80, 0; -70, 20; -60, -20; -50, 20; -40, -20; -30, 
               20; -20, -20; -10, 20; 0, -20; 10, 20; 20, 0; 40, 0], style(
              color=0)), 
        Line(points=[40, 60; 40, -60], style(color=0)), 
        Line(points=[50, 30; 50, -30], style(color=0)), 
        Line(points=[50, 0; 100, 0], style(color=0)), 
        Line(points=[0, -30; -60, 32], style(color=0)), 
        Line(points=[-60, 32; -54, 32], style(color=0)), 
        Line(points=[-60, 32; -60, 26], style(color=0)), 
        Text(extent=[60, 40; 100, 20], string="K")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.39, 
        y=0.39, 
        width=0.6, 
        height=0.6));
  equation 
    G = n_prob^4*g_max;
    i = G*(v - E_K);
    der(n_prob) = 1000*(a_n*(1 - n_prob) - b_n*n_prob);
    a_n = .01*(E + V_an)/(1 - Modelica.Math.exp(-(E + V_an)/10));
    b_n = .125*Modelica.Math.exp(-(E + V_bn)/80);
  end PotassiumChannel;

  model LeakageChannel "Hodgkin-Huxley Leakage Channel" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Area membrane_area;
  protected 
    parameter SIunits.Conductance g_max=membrane_area*G_L;
    annotation (
      Diagram, 
      Icon(
        Line(points=[-98, 0; -80, 0; -70, 20; -60, -20; -50, 20; -40, -20; -30, 
               20; -20, -20; -10, 20; 0, -20; 10, 20; 20, 0; 40, 0], style(
              color=0)), 
        Line(points=[40, 60; 40, -60], style(color=0)), 
        Line(points=[50, 30; 50, -30], style(color=0)), 
        Line(points=[50, 0; 100, 0], style(color=0)), 
        Line(points=[0, -30; -60, 32], style(color=0)), 
        Line(points=[-60, 32; -54, 32], style(color=0)), 
        Line(points=[-60, 32; -60, 26], style(color=0)), 
        Text(extent=[60, 40; 100, 20], string="Leak")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.1, 
        y=0.15, 
        width=0.6, 
        height=0.6));
  equation 
    i = g_max*(v - E_L);
  end LeakageChannel;
  
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100], 
      grid=[2, 2], 
      component=[20, 20]), 
    Documentation(info="Useful sites:

http://www.iam.ubc.ca/guides/xppaut/newstyle.html#hh
http://retina.anatomy.upenn.edu/~lance/modelmath/hodgkin_huxley.html
http://www.bbb.caltech.edu/GENESIS/cnsweb/cns1.html"), 
    Window(
      x=0.39, 
      y=0.39, 
      width=0.6, 
      height=0.6, 
      library=1, 
      autolayout=1));
end HodgkinHuxley;
