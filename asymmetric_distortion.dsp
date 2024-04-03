import("stdfaust.lib");

process =
  dist(gain1, gain2) , dist(gain2, gain1)
  with
  {
    dist(gain1, gain2) =
        _
      <:
          (_  * gain1 <: _ * >(0) : aa.tanh1 / gain1)
        ,
          (_  * gain2 <: _ * <(0) : aa.tanh1 / gain2)
      :>
        _;

    gain1 = hslider("[0]Gain 1", 10, 0, 40, 0.01) : ba.db2linear;
    gain2 = hslider("[0]Gain 2", 0, 0, 40, 0.01) : ba.db2linear;
  };
