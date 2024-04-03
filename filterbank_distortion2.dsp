import("stdfaust.lib");

process =
    _
  <:
    par(i, 24, filter(i))
  :> _,_
with {
  filter(i) =
      fi.svf.bp(220 *pow(2,3*i/12), pre_q) * pre_gain
    :
      aa.tanh1
    :
      fi.svf.bp(220 *pow(2,3*i/12), post_q) * post_gain
  ;
  pre_gain = hslider("[0]Pre Gain", 30, 0, 92, 0.1) : ba.db2linear;
  pre_q = hslider("[1]Pre Q", 2, 0.1, 30, 0.1);
  post_gain = hslider("[2]Post Gain", -20, -36, 92, 0.1) : ba.db2linear;
  post_q = hslider("[3]Post Q", 4, 0.1, 30, 0.1);
};
