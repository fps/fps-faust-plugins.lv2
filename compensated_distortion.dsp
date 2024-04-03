import("stdfaust.lib");

process =
    _
  <:
      stage(1, 500, 800, 1200, 40, -20)
    , stage(2, 1000, 2000, 4000, 20, -10)
  :>
    _
  with
  {
    stage(n, pre_hp_cutoff, pre_lp_cutoff, post_lp_cutoff, pre_gain, post_gain) =
        _
      <:
        (
            pre_filter(n, pre_hp_cutoff, pre_lp_cutoff)
          :
            gain_stage(n, pre_gain)
          :
            post_filter(n, post_lp_cutoff, post_gain)
        )
        , _ - pre_filter(n, pre_hp_cutoff, pre_lp_cutoff)
      :>
        (
            _
          *
            (
              hslider("[%n][09] Stage %n -  Gain", -3, -32, 32, 0.01)
              : ba.db2linear
            )
        )
      ;

    pre_filter(n, hp_cutoff, lp_cutoff) =
        fi.svf.hp
        (
          hslider("[%n][01] Stage %n - Pre - High - Cutoff", hp_cutoff, 1, 5000, 0.01),
          hslider("[%n][02] Stage %n - Pre - High - Q", 0.7071, 0.1, 5, 0.01)
        )
      :
        fi.svf.lp
        (
          hslider("[%n][03] Stage %n - Pre - Low - Cutoff", lp_cutoff, 1, 5000, 0.01),
          hslider("[%n][04] Stage %n - Pre - Low - Q", 0.7071, 0.1, 5, 0.01)
        )
      ;

    gain_stage(n, gain) =
        (
            _
          *
            (
                hslider("[%n][05] Stage %n - Pre - Gain", gain, -32, 64, 0.01)
              : ba.db2linear
            )
        )
      :
        aa.tanh1
      ;

    post_filter(n, lp_cutoff, gain) =
        fi.svf.lp
        (
          hslider("[%n][06] Stage %n - Post - Low - Cutoff", lp_cutoff, 1, 5000, 0.01),
          hslider("[%n][07] Stage %n - Post - Low - Q", 0.7071, 0.1, 5, 0.01)
        )
      *
        (
          hslider("[%n][08] Stage %n - Post - Gain", gain, -32, 64, 0.01)
          : ba.db2linear
        )
      ;
};

