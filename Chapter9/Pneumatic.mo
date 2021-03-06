package Pneumatic 
  package Interfaces 
    connector Port 
      Real x;
    end Port;
  end Interfaces;

  model Valve 
    Pneumatic.Interfaces.Port p1 annotation (extent=[-110, 10; -90, 30]);
    Interfaces.Port p2 annotation (extent=[90, 10; 110, 30]);
    connector Port 
      extends Interfaces.Port;
    end Port;
    Port p3 annotation (extent=[-110, -30; -90, -10]);
  end Valve;

  model Pump 
    import BookExamples.Chapter9.Pneumatic.Interfaces.Port;
    Port p1 annotation (extent=[-110, -10; -90, 10]);
  end Pump;

  encapsulated model Test 
    import BookExamples.Chapter9.Pneumatic;
    Pneumatic.Valve v annotation (extent=[-60, 0; -40, 20]);
    Pneumatic.Pump p annotation (extent=[20, 0; 40, 20]);
  end Test;
end Pneumatic;
