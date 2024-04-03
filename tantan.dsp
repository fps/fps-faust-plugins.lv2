import("stdfaust.lib");

process =
    _ 
  * 
    (hslider("Gain", 0, -40, 40, 0.1) : ba.db2linear) 
  + 
    (hslider("Offset", 0, -40, 40, 0.01) : ba.db2linear) 
  : 
    aa.tanh1 
  : 
    fi.dcblocker
  ;
