model EmptyingTank2 
  Real x;
  Boolean cond;
equation 
  cond = x > 0;
  der(x) = if cond then -(x^.5) else 0.0;
end EmptyingTank2;
